/*
 * Copyright 2019 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_LOCAL_LOCAL_STORE_H_
#define FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_LOCAL_LOCAL_STORE_H_

#include <memory>
#include <unordered_map>
#include <vector>

#include "Firestore/core/src/firebase/firestore/auth/user.h"
#include "Firestore/core/src/firebase/firestore/core/target_id_generator.h"
#include "Firestore/core/src/firebase/firestore/local/local_documents_view.h"
#include "Firestore/core/src/firebase/firestore/local/local_view_changes.h"
#include "Firestore/core/src/firebase/firestore/local/local_write_result.h"
#include "Firestore/core/src/firebase/firestore/local/lru_garbage_collector.h"
#include "Firestore/core/src/firebase/firestore/local/persistence.h"
#include "Firestore/core/src/firebase/firestore/local/reference_set.h"
#include "Firestore/core/src/firebase/firestore/model/document_key_set.h"
#include "Firestore/core/src/firebase/firestore/model/document_map.h"
#include "Firestore/core/src/firebase/firestore/model/mutation.h"
#include "Firestore/core/src/firebase/firestore/model/mutation_batch_result.h"
#include "Firestore/core/src/firebase/firestore/remote/remote_event.h"
#include "absl/types/optional.h"

namespace firebase {
namespace firestore {
namespace local {

/**
 * Local storage in the Firestore client. Coordinates persistence components
 * like the mutation queue and remote document cache to present a latency
 * compensated view of stored data.
 *
 * The LocalStore is responsible for accepting mutations from the SyncEngine.
 * Writes from the client are put into a queue as provisional Mutations until
 * they are processed by the RemoteStore and confirmed as having been written to
 * the server.
 *
 * The local store provides the local version of documents that have been
 * modified locally. It maintains the constraint:
 *
 *  LocalDocument = RemoteDocument + Active(LocalMutations)
 *
 * (Active mutations are those that are enqueued and have not been previously
 * acknowledged or rejected).
 *
 * The RemoteDocument ("ground truth") state is provided via the
 * ApplyChangeBatch method. It will be some version of a server-provided
 * document OR will be a server-provided document PLUS acknowledged mutations:
 *
 *  RemoteDocument' = RemoteDocument + Acknowledged(LocalMutations)
 *
 * Note that this "dirty" version of a RemoteDocument will not be identical to a
 * server base version, since it has LocalMutations added to it pending getting
 * an authoritative copy from the server.
 *
 * Since LocalMutations can be rejected by the server, we have to be able to
 * revert a LocalMutation that has already been applied to the LocalDocument
 * (typically done by replaying all remaining LocalMutations to the
 * RemoteDocument to re-apply).
 *
 * It also maintains the persistence of mapping queries to resume tokens and
 * target ids.
 *
 * The LocalStore must be able to efficiently execute queries against its local
 * cache of the documents, to provide the initial set of results before any
 * remote changes have been received.
 */
class LocalStore {
 public:
  LocalStore(Persistence* persistence, const auth::User& initial_user);

  /** Performs any initial startup actions required by the local store. */
  void Start();

  /**
   * Tells the LocalStore that the currently authenticated user has changed.
   *
   * In response the local store switches the mutation queue to the new user and
   * returns any resulting document changes.
   */
  model::MaybeDocumentMap HandleUserChange(const auth::User& user);

  /** Accepts locally generated Mutations and commits them to storage. */
  local::LocalWriteResult WriteLocally(
      std::vector<model::Mutation>&& mutations);

  /**
   * Returns the current value of a document with a given key, or `nullopt` if
   * not found.
   */
  absl::optional<model::MaybeDocument> ReadDocument(
      const model::DocumentKey& key);

  /**
   * Acknowledges the given batch.
   *
   * On the happy path when a batch is acknowledged, the local store will:
   *
   * + remove the batch from the mutation queue;
   * + apply the changes to the remote document cache;
   * + recalculate the latency compensated view implied by those changes (there
   * may be mutations in the queue that affect the documents but haven't been
   * acknowledged yet); and
   * + give the changed documents back the sync engine
   *
   * @return The resulting (modified) documents.
   */
  model::MaybeDocumentMap AcknowledgeBatch(
      const model::MutationBatchResult& batch_result);

  /**
   * Removes mutations from the MutationQueue for the specified batch.
   * LocalDocuments will be recalculated.
   *
   * @return The resulting (modified) documents.
   */
  model::MaybeDocumentMap RejectBatch(model::BatchId batch_id);

  /** Returns the last recorded stream token for the current user. */
  nanopb::ByteString GetLastStreamToken();

  /**
   * Sets the stream token for the current user without acknowledging any
   * mutation batch. This is usually only useful after a stream handshake or in
   * response to an error that requires clearing the stream token.
   */
  void SetLastStreamToken(const nanopb::ByteString& stream_token);

  /**
   * Returns the last consistent snapshot processed (used by the RemoteStore to
   * determine whether to buffer incoming snapshots from the backend).
   */
  const model::SnapshotVersion& GetLastRemoteSnapshotVersion() const;

  /**
   * Updates the "ground-state" (remote) documents. We assume that the remote
   * event reflects any write batches that have been acknowledged or rejected
   * (i.e. we do not re-apply local mutations to updates from this event).
   *
   * LocalDocuments are re-calculated if there are remaining mutations in the
   * queue.
   */
  model::MaybeDocumentMap ApplyRemoteEvent(
      const remote::RemoteEvent& remote_event);

  /**
   * Returns the keys of the documents that are associated with the given
   * target_id in the remote table.
   */
  model::DocumentKeySet GetRemoteDocumentKeys(model::TargetId target_id);

  /**
   * Assigns a query an internal ID so that its results can be pinned so they
   * don't get GC'd. A query must be allocated in the local store before the
   * store can be used to manage its view.
   */
  local::QueryData AllocateQuery(core::Query query);

  /** Unpin all the documents associated with a query. */
  void ReleaseQuery(const core::Query& query);

  /**
   * Runs a query against all the documents in the local store and returns the
   * results.
   */
  model::DocumentMap ExecuteQuery(const core::Query& query);

  /**
   * Notify the local store of the changed views to locally pin / unpin
   * documents.
   */
  void NotifyLocalViewChanges(
      const std::vector<local::LocalViewChanges>& view_changes);

  /**
   * Gets the mutation batch after the passed in batch_id in the mutation queue
   * or `nullopt` if empty.
   *
   * @param batch_id The batch to search after, or `kBatchIdUnknown` for the
   * first mutation in the queue.
   * @return the next mutation or `nullopt` if there wasn't one.
   */
  absl::optional<model::MutationBatch> GetNextMutationBatch(
      model::BatchId batch_id);

  /**
   * Returns the largest (latest) batch id in mutation queue that is pending
   * server response. Returns `kBatchIdUnknown` if the queue is empty.
   */
  model::BatchId GetHighestUnacknowledgedBatchId();

  local::LruResults CollectGarbage(
      local::LruGarbageCollector* garbage_collector);

 private:
  void StartMutationQueue();
  void ApplyBatchResult(const model::MutationBatchResult& batch_result);

  /**
   * Returns true if the new_query_data should be persisted during an update of
   * an active target. QueryData should always be persisted when a target is
   * being released and should not call this function.
   *
   * While the target is active, QueryData updates can be omitted when nothing
   * about the target has changed except metadata like the resume token or
   * snapshot version. Occasionally it's worth the extra write to prevent these
   * values from getting too stale after a crash, but this doesn't have to be
   * too frequent.
   */
  bool ShouldPersistQueryData(const QueryData& new_query_data,
                              const local::QueryData& old_query_data,
                              const remote::TargetChange& change) const;

  /** Manages our in-memory or durable persistence. Owned by FirestoreClient. */
  Persistence* persistence_ = nullptr;

  /** Used to generate target IDs for queries tracked locally. */
  core::TargetIdGenerator target_id_generator_;

  /**
   * The set of all mutations that have been sent but not yet been applied to
   * the backend.
   */
  MutationQueue* mutation_queue_ = nullptr;

  /** The set of all cached remote documents. */
  RemoteDocumentCache* remote_document_cache_ = nullptr;

  /** Maps a query to the data about that query. */
  QueryCache* query_cache_ = nullptr;

  /**
   * The "local" view of all documents (layering mutation queue on top of
   * remote_document_cache_).
   */
  std::unique_ptr<LocalDocumentsView> local_documents_;

  /** The set of document references maintained by any local views. */
  ReferenceSet local_view_references_;

  /** Maps target ids to data about their queries. */
  std::unordered_map<model::TargetId, QueryData> target_ids;
};

}  // namespace local
}  // namespace firestore
}  // namespace firebase

#endif  // FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_LOCAL_LOCAL_STORE_H_
