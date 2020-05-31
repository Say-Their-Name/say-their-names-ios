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

#include "Firestore/core/src/firebase/firestore/local/index_free_query_engine.h"

#include <utility>

#include "Firestore/core/src/firebase/firestore/core/query.h"
#include "Firestore/core/src/firebase/firestore/local/local_documents_view.h"
#include "Firestore/core/src/firebase/firestore/model/document.h"
#include "Firestore/core/src/firebase/firestore/model/maybe_document.h"
#include "Firestore/core/src/firebase/firestore/model/snapshot_version.h"
#include "Firestore/core/src/firebase/firestore/util/log.h"

namespace firebase {
namespace firestore {
namespace local {

using core::Query;
using model::Document;
using model::DocumentKeySet;
using model::DocumentMap;
using model::DocumentSet;
using model::MaybeDocument;
using model::MaybeDocumentMap;
using model::SnapshotVersion;

DocumentMap IndexFreeQueryEngine::GetDocumentsMatchingQuery(
    const Query& query,
    const SnapshotVersion& last_limbo_free_snapshot_version,
    const DocumentKeySet& remote_keys) {
  HARD_ASSERT(local_documents_view_, "SetLocalDocumentsView() not called");

  // Queries that match all documents don't benefit from using IndexFreeQueries.
  // It is more efficient to scan all documents in a collection, rather than to
  // perform individual lookups.
  if (query.MatchesAllDocuments()) {
    return ExecuteFullCollectionScan(query);
  }

  // Queries that have never seen a snapshot without limbo free documents should
  // also be run as a full collection scan.
  if (last_limbo_free_snapshot_version == SnapshotVersion::None()) {
    return ExecuteFullCollectionScan(query);
  }

  MaybeDocumentMap documents = local_documents_view_->GetDocuments(remote_keys);
  DocumentSet previous_results = ApplyQuery(query, documents);

  if (query.limit() != Query::kNoLimit &&
      NeedsRefill(previous_results, remote_keys,
                  last_limbo_free_snapshot_version)) {
    return ExecuteFullCollectionScan(query);
  }

  LOG_DEBUG("Re-using previous result from %s to execute query: %s",
            last_limbo_free_snapshot_version.ToString(), query.ToString());

  // Retrieve all results for documents that were updated since the last
  // remote snapshot that did not contain any Limbo documents.
  DocumentMap updated_results =
      local_documents_view_->GetDocumentsMatchingQuery(
          query, last_limbo_free_snapshot_version);

  // We merge `previous_results` into `update_results`, since `update_results`
  // is already a DocumentMap. If a document is contained in both lists, then
  // its contents are the same.
  for (const Document& result : previous_results) {
    updated_results = updated_results.insert(result.key(), result);
  }

  return updated_results;
}

DocumentSet IndexFreeQueryEngine::ApplyQuery(
    const Query& query, const MaybeDocumentMap& documents) const {
  // Sort the documents and re-apply the query filter since previously matching
  // documents do not necessarily still match the query.
  DocumentSet query_results(query.Comparator());

  for (const auto& document_entry : documents) {
    const MaybeDocument& maybe_doc = document_entry.second;
    if (maybe_doc.is_document()) {
      Document doc(maybe_doc);
      if (query.Matches(doc)) {
        query_results = query_results.insert(std::move(doc));
      }
    }
  }
  return query_results;
}

bool IndexFreeQueryEngine::NeedsRefill(
    const DocumentSet& sorted_previous_results,
    const DocumentKeySet& remote_keys,
    const SnapshotVersion& limbo_free_snapshot_version) const {
  // The query needs to be refilled if a previously matching document no longer
  // matches.
  if (remote_keys.size() != sorted_previous_results.size()) {
    return true;
  }

  // Limit queries are not eligible for index-free query execution if there is a
  // potential that an older document from cache now sorts before a document
  // that was previously part of the limit. This, however, can only happen if
  // the last document of the limit sorts lower than it did when the query was
  // last synchronized. If a document that is not the limit boundary sorts
  // differently, the boundary of the limit itself did not change and documents
  // from cache will continue to be "rejected" by this boundary. Therefore, we
  // can ignore any modifications that don't affect the last document.
  absl::optional<Document> last_document_in_limit =
      sorted_previous_results.GetLastDocument();
  if (!last_document_in_limit) {
    // We don't need to refill the query if there were already no documents.
    return false;
  }
  return last_document_in_limit->has_pending_writes() ||
         last_document_in_limit->version() > limbo_free_snapshot_version;
}

DocumentMap IndexFreeQueryEngine::ExecuteFullCollectionScan(
    const Query& query) {
  LOG_DEBUG("Using full collection scan to execute query: %s",
            query.ToString());
  return local_documents_view_->GetDocumentsMatchingQuery(
      query, SnapshotVersion::None());
}

}  // namespace local
}  // namespace firestore
}  // namespace firebase
