/*
 * Copyright 2018 Google
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

#ifndef FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_LOCAL_LEVELDB_QUERY_CACHE_H_
#define FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_LOCAL_LEVELDB_QUERY_CACHE_H_

#include <unordered_map>

#include "Firestore/Protos/nanopb/firestore/local/target.nanopb.h"
#include "Firestore/core/src/firebase/firestore/local/query_cache.h"
#include "Firestore/core/src/firebase/firestore/local/query_data.h"
#include "Firestore/core/src/firebase/firestore/model/document_key.h"
#include "Firestore/core/src/firebase/firestore/model/document_key_set.h"
#include "Firestore/core/src/firebase/firestore/model/types.h"
#include "Firestore/core/src/firebase/firestore/nanopb/message.h"
#include "absl/strings/string_view.h"
#include "absl/types/optional.h"
#include "leveldb/db.h"

namespace firebase {
namespace firestore {
namespace local {

class LevelDbPersistence;
class LocalSerializer;

/** Cached Queries backed by LevelDB. */
class LevelDbQueryCache : public QueryCache {
 public:
  /**
   * Retrieves the global singleton metadata row from the given database. If the
   * metadata row doesn't exist, this will result in an assertion failure.
   *
   * TODO(gsoltis): remove this method once fully ported to transactions.
   */
  static nanopb::Message<firestore_client_TargetGlobal> ReadMetadata(
      leveldb::DB* db);

  /**
   * Test-only -- same as `ReadMetadata`, but returns an empty optional if the
   * metadata row doesn't exist.
   */
  static absl::optional<nanopb::Message<firestore_client_TargetGlobal>>
  TryReadMetadata(leveldb::DB* db);

  /**
   * Creates a new query cache in the given LevelDB.
   *
   * @param db The LevelDB in which to create the cache.
   */
  LevelDbQueryCache(LevelDbPersistence* db, LocalSerializer* serializer);

  // Target-related methods
  void AddTarget(const QueryData& query_data) override;

  void UpdateTarget(const QueryData& query_data) override;

  void RemoveTarget(const QueryData& query_data) override;

  absl::optional<QueryData> GetTarget(const core::Query& query) override;

  void EnumerateTargets(const TargetCallback& callback) override;

  int RemoveTargets(model::ListenSequenceNumber upper_bound,
                    const std::unordered_map<model::TargetId, QueryData>&
                        live_targets) override;

  // Key-related methods

  /**
   * Adds the given document keys to cached query results of the given target
   * ID.
   */
  void AddMatchingKeys(const model::DocumentKeySet& keys,
                       model::TargetId target_id) override;

  /** Removes the given document keys from the cached query results of the given
   * target ID. */
  void RemoveMatchingKeys(const model::DocumentKeySet& keys,
                          model::TargetId target_id) override;

  /** Removes all the keys in the query results of the given target ID. */
  void RemoveAllKeysForTarget(model::TargetId target_id);

  model::DocumentKeySet GetMatchingKeys(model::TargetId target_id) override;

  /**
   * Checks to see if there are any references to a document with the given key.
   */
  bool Contains(const model::DocumentKey& key) override;

  // Other methods and accessors
  size_t size() const override {
    return metadata_->target_count;
  }

  model::TargetId highest_target_id() const override {
    return metadata_->highest_target_id;
  }

  model::ListenSequenceNumber highest_listen_sequence_number() const override {
    return metadata_->highest_listen_sequence_number;
  }

  const model::SnapshotVersion& GetLastRemoteSnapshotVersion() const override;

  void SetLastRemoteSnapshotVersion(model::SnapshotVersion version) override;

  // Non-interface methods
  void Start();

  void EnumerateOrphanedDocuments(const OrphanedDocumentCallback& callback);

 private:
  void Save(const QueryData& query_data);
  bool UpdateMetadata(const QueryData& query_data);
  void SaveMetadata();

  /**
   * Parses the given bytes as a `firestore_client_Target` protocol buffer and
   * then converts to the equivalent query data.
   */
  QueryData DecodeTarget(absl::string_view encoded);

  // The LevelDbQueryCache is owned by LevelDbPersistence.
  LevelDbPersistence* db_;
  // Owned by LevelDbPersistence.
  LocalSerializer* serializer_ = nullptr;

  /** A write-through cached copy of the metadata for the query cache. */
  nanopb::Message<firestore_client_TargetGlobal> metadata_;

  model::SnapshotVersion last_remote_snapshot_version_;
};

}  // namespace local
}  // namespace firestore
}  // namespace firebase

#endif  // FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_LOCAL_LEVELDB_QUERY_CACHE_H_
