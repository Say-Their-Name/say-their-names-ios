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

#ifndef FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_LOCAL_LEVELDB_REMOTE_DOCUMENT_CACHE_H_
#define FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_LOCAL_LEVELDB_REMOTE_DOCUMENT_CACHE_H_

#include <vector>

#include "Firestore/core/src/firebase/firestore/local/remote_document_cache.h"
#include "Firestore/core/src/firebase/firestore/model/document_key.h"
#include "Firestore/core/src/firebase/firestore/model/document_key_set.h"
#include "Firestore/core/src/firebase/firestore/model/document_map.h"
#include "Firestore/core/src/firebase/firestore/model/maybe_document.h"
#include "Firestore/core/src/firebase/firestore/model/types.h"
#include "absl/strings/string_view.h"

namespace firebase {
namespace firestore {
namespace local {

class LevelDbPersistence;
class LocalSerializer;

/** Cached Remote Documents backed by leveldb. */
class LevelDbRemoteDocumentCache : public RemoteDocumentCache {
 public:
  LevelDbRemoteDocumentCache(LevelDbPersistence* db,
                             LocalSerializer* serializer);

  void Add(const model::MaybeDocument& document,
           const model::SnapshotVersion& read_time) override;
  void Remove(const model::DocumentKey& key) override;

  absl::optional<model::MaybeDocument> Get(
      const model::DocumentKey& key) override;
  model::OptionalMaybeDocumentMap GetAll(
      const model::DocumentKeySet& keys) override;
  model::DocumentMap GetMatching(
      const core::Query& query,
      const model::SnapshotVersion& since_read_time) override;

 private:
  /**
   * Looks up a set of entries in the cache, returning only existing entries of
   * Type::Document.
   */
  model::DocumentMap GetAllExisting(const model::DocumentKeySet& keys);

  model::MaybeDocument DecodeMaybeDocument(absl::string_view encoded,
                                           const model::DocumentKey& key);

  // The LevelDbRemoteDocumentCache instance is owned by LevelDbPersistence.
  LevelDbPersistence* db_;
  // Owned by LevelDbPersistence.
  LocalSerializer* serializer_ = nullptr;
};

}  // namespace local
}  // namespace firestore
}  // namespace firebase

#endif  // FIRESTORE_CORE_SRC_FIREBASE_FIRESTORE_LOCAL_LEVELDB_REMOTE_DOCUMENT_CACHE_H_
