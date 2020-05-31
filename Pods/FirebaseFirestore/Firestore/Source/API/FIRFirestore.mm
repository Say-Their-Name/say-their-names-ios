/*
 * Copyright 2017 Google
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

#import "FIRFirestore+Internal.h"

#import <FirebaseCore/FIRApp.h>
#import <FirebaseCore/FIRAppInternal.h>
#import <FirebaseCore/FIRComponentContainer.h>
#import <FirebaseCore/FIROptions.h>

#include <memory>
#include <string>
#include <utility>

#import "FIRFirestoreSettings+Internal.h"

#import "Firestore/Source/API/FIRCollectionReference+Internal.h"
#import "Firestore/Source/API/FIRDocumentReference+Internal.h"
#import "Firestore/Source/API/FIRFirestore+Internal.h"
#import "Firestore/Source/API/FIRListenerRegistration+Internal.h"
#import "Firestore/Source/API/FIRQuery+Internal.h"
#import "Firestore/Source/API/FIRTransaction+Internal.h"
#import "Firestore/Source/API/FIRWriteBatch+Internal.h"
#import "Firestore/Source/API/FSTFirestoreComponent.h"
#import "Firestore/Source/API/FSTUserDataConverter.h"

#include "Firestore/core/src/firebase/firestore/api/collection_reference.h"
#include "Firestore/core/src/firebase/firestore/api/firestore.h"
#include "Firestore/core/src/firebase/firestore/api/write_batch.h"
#include "Firestore/core/src/firebase/firestore/auth/credentials_provider.h"
#include "Firestore/core/src/firebase/firestore/core/database_info.h"
#include "Firestore/core/src/firebase/firestore/core/transaction.h"
#include "Firestore/core/src/firebase/firestore/model/database_id.h"
#include "Firestore/core/src/firebase/firestore/util/async_queue.h"
#include "Firestore/core/src/firebase/firestore/util/empty.h"
#include "Firestore/core/src/firebase/firestore/util/error_apple.h"
#include "Firestore/core/src/firebase/firestore/util/exception.h"
#include "Firestore/core/src/firebase/firestore/util/exception_apple.h"
#include "Firestore/core/src/firebase/firestore/util/executor_libdispatch.h"
#include "Firestore/core/src/firebase/firestore/util/hard_assert.h"
#include "Firestore/core/src/firebase/firestore/util/log.h"
#include "Firestore/core/src/firebase/firestore/util/status.h"
#include "Firestore/core/src/firebase/firestore/util/statusor.h"
#include "Firestore/core/src/firebase/firestore/util/string_apple.h"

namespace util = firebase::firestore::util;
using firebase::firestore::api::DocumentReference;
using firebase::firestore::api::Firestore;
using firebase::firestore::api::ListenerRegistration;
using firebase::firestore::auth::CredentialsProvider;
using firebase::firestore::core::EventListener;
using firebase::firestore::model::DatabaseId;
using firebase::firestore::util::AsyncQueue;
using firebase::firestore::util::Empty;
using firebase::firestore::util::ObjcThrowHandler;
using firebase::firestore::util::SetThrowHandler;
using firebase::firestore::util::StatusOr;
using firebase::firestore::util::ThrowIllegalState;
using firebase::firestore::util::ThrowInvalidArgument;

using UserUpdateBlock = id _Nullable (^)(FIRTransaction *, NSError **);
using UserTransactionCompletion = void (^)(id _Nullable, NSError *_Nullable);

NS_ASSUME_NONNULL_BEGIN

#pragma mark - FIRFirestore

@interface FIRFirestore ()

@property(nonatomic, strong, readonly) FSTUserDataConverter *dataConverter;

@end

@implementation FIRFirestore {
  std::shared_ptr<Firestore> _firestore;
  FIRFirestoreSettings *_settings;
  __weak id<FSTFirestoreInstanceRegistry> _registry;
}

+ (void)initialize {
  if (self == [FIRFirestore class]) {
    SetThrowHandler(ObjcThrowHandler);
  }
}

+ (instancetype)firestore {
  FIRApp *app = [FIRApp defaultApp];
  if (!app) {
    ThrowIllegalState("Failed to get FirebaseApp instance. Please call FirebaseApp.configure() "
                      "before using Firestore");
  }
  return [self firestoreForApp:app database:util::MakeNSString(DatabaseId::kDefault)];
}

+ (instancetype)firestoreForApp:(FIRApp *)app {
  return [self firestoreForApp:app database:util::MakeNSString(DatabaseId::kDefault)];
}

// TODO(b/62410906): make this public
+ (instancetype)firestoreForApp:(FIRApp *)app database:(NSString *)database {
  if (!app) {
    ThrowInvalidArgument("FirebaseApp instance may not be nil. Use FirebaseApp.app() if you'd like "
                         "to use the default FirebaseApp instance.");
  }
  if (!database) {
    ThrowInvalidArgument("Database identifier may not be nil. Use '%s' if you want the default "
                         "database",
                         DatabaseId::kDefault);
  }

  id<FSTFirestoreMultiDBProvider> provider =
      FIR_COMPONENT(FSTFirestoreMultiDBProvider, app.container);
  return [provider firestoreForDatabase:database];
}

- (instancetype)initWithDatabaseID:(model::DatabaseId)databaseID
                    persistenceKey:(std::string)persistenceKey
               credentialsProvider:(std::shared_ptr<CredentialsProvider>)credentialsProvider
                       workerQueue:(std::shared_ptr<AsyncQueue>)workerQueue
                       firebaseApp:(FIRApp *)app
                  instanceRegistry:(nullable id<FSTFirestoreInstanceRegistry>)registry {
  if (self = [super init]) {
    _firestore = std::make_shared<Firestore>(std::move(databaseID), std::move(persistenceKey),
                                             std::move(credentialsProvider), std::move(workerQueue),
                                             (__bridge void *)self);

    _app = app;
    _registry = registry;

    FSTPreConverterBlock block = ^id _Nullable(id _Nullable input) {
      if ([input isKindOfClass:[FIRDocumentReference class]]) {
        FIRDocumentReference *documentReference = (FIRDocumentReference *)input;
        return [[FSTDocumentKeyReference alloc] initWithKey:documentReference.key
                                                 databaseID:documentReference.firestore.databaseID];
      } else {
        return input;
      }
    };

    _dataConverter = [[FSTUserDataConverter alloc] initWithDatabaseID:_firestore->database_id()
                                                         preConverter:block];
    // Use the property setter so the default settings get plumbed into _firestoreClient.
    self.settings = [[FIRFirestoreSettings alloc] init];
  }
  return self;
}

- (FIRFirestoreSettings *)settings {
  // Disallow mutation of our internal settings
  return [_settings copy];
}

- (void)setSettings:(FIRFirestoreSettings *)settings {
  if (![settings isEqual:_settings]) {
    _settings = settings;
    _firestore->set_settings([settings internalSettings]);

    std::unique_ptr<util::Executor> user_executor =
        absl::make_unique<util::ExecutorLibdispatch>(settings.dispatchQueue);
    _firestore->set_user_executor(std::move(user_executor));
  }
}

- (FIRCollectionReference *)collectionWithPath:(NSString *)collectionPath {
  if (!collectionPath) {
    ThrowInvalidArgument("Collection path cannot be nil.");
  }
  if ([collectionPath containsString:@"//"]) {
    ThrowInvalidArgument("Invalid path (%s). Paths must not contain // in them.", collectionPath);
  }

  return [[FIRCollectionReference alloc]
      initWithReference:_firestore->GetCollection(util::MakeString(collectionPath))];
}

- (FIRDocumentReference *)documentWithPath:(NSString *)documentPath {
  if (!documentPath) {
    ThrowInvalidArgument("Document path cannot be nil.");
  }
  if ([documentPath containsString:@"//"]) {
    ThrowInvalidArgument("Invalid path (%s). Paths must not contain // in them.", documentPath);
  }

  DocumentReference documentReference = _firestore->GetDocument(util::MakeString(documentPath));
  return [[FIRDocumentReference alloc] initWithReference:std::move(documentReference)];
}

- (FIRQuery *)collectionGroupWithID:(NSString *)collectionID {
  if (!collectionID) {
    ThrowInvalidArgument("Collection ID cannot be nil.");
  }
  if ([collectionID containsString:@"/"]) {
    ThrowInvalidArgument("Invalid collection ID (%s). Collection IDs must not contain / in them.",
                         collectionID);
  }

  auto query = _firestore->GetCollectionGroup(util::MakeString(collectionID));
  return [[FIRQuery alloc] initWithQuery:std::move(query) firestore:_firestore];
}

- (FIRWriteBatch *)batch {
  return [FIRWriteBatch writeBatchWithDataConverter:self.dataConverter
                                         writeBatch:_firestore->GetBatch()];
}

- (void)runTransactionWithBlock:(UserUpdateBlock)updateBlock
                  dispatchQueue:(dispatch_queue_t)queue
                     completion:(UserTransactionCompletion)completion {
  if (!updateBlock) {
    ThrowInvalidArgument("Transaction block cannot be nil.");
  }
  if (!completion) {
    ThrowInvalidArgument("Transaction completion block cannot be nil.");
  }

  class TransactionResult {
   public:
    TransactionResult(FIRFirestore *firestore,
                      UserUpdateBlock update_block,
                      dispatch_queue_t queue,
                      UserTransactionCompletion completion)
        : firestore_(firestore),
          user_update_block_(update_block),
          queue_(queue),
          user_completion_(completion) {
    }

    void RunUpdateBlock(std::shared_ptr<core::Transaction> internalTransaction,
                        core::TransactionResultCallback internalCallback) {
      dispatch_async(queue_, ^{
        auto transaction = [FIRTransaction transactionWithInternalTransaction:internalTransaction
                                                                    firestore:firestore_];

        NSError *_Nullable error = nil;
        user_result_ = user_update_block_(transaction, &error);

        // If the user set an error, disregard the result.
        if (error) {
          // If the error is a user error, set flag to not retry the transaction.
          if (error.domain != FIRFirestoreErrorDomain) {
            internalTransaction->MarkPermanentlyFailed();
          }
          internalCallback(util::Status::FromNSError(error));
        } else {
          internalCallback(util::Status::OK());
        }
      });
    }

    void HandleFinalStatus(const util::Status &status) {
      if (!status.ok()) {
        user_completion_(nil, util::MakeNSError(status));
        return;
      }

      user_completion_(user_result_, nil);
    }

   private:
    FIRFirestore *firestore_;
    UserUpdateBlock user_update_block_;
    dispatch_queue_t queue_;
    UserTransactionCompletion user_completion_;

    id _Nullable user_result_;
  };

  auto result_capture = std::make_shared<TransactionResult>(self, updateBlock, queue, completion);

  // Wrap the user-supplied updateBlock in a core C++ compatible callback. Wrap the result of the
  // updateBlock invocation up in a TransactionResult for tunneling through the internals of the
  // system.
  auto internalUpdateBlock = [result_capture](
                                 std::shared_ptr<core::Transaction> internalTransaction,
                                 core::TransactionResultCallback internalCallback) {
    result_capture->RunUpdateBlock(internalTransaction, internalCallback);
  };

  // Unpacks the TransactionResult value and calls the user completion handler.
  //
  // PORTING NOTE: Other platforms where the user return value is internally representable don't
  // need this wrapper.
  auto objcTranslator = [result_capture](const util::Status &status) {
    result_capture->HandleFinalStatus(status);
  };

  _firestore->RunTransaction(std::move(internalUpdateBlock), std::move(objcTranslator));
}

- (void)runTransactionWithBlock:(id _Nullable (^)(FIRTransaction *, NSError **error))updateBlock
                     completion:
                         (void (^)(id _Nullable result, NSError *_Nullable error))completion {
  static dispatch_queue_t transactionDispatchQueue;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    transactionDispatchQueue = dispatch_queue_create("com.google.firebase.firestore.transaction",
                                                     DISPATCH_QUEUE_CONCURRENT);
  });
  [self runTransactionWithBlock:updateBlock
                  dispatchQueue:transactionDispatchQueue
                     completion:completion];
}

+ (void)enableLogging:(BOOL)logging {
  util::LogSetLevel(logging ? util::kLogLevelDebug : util::kLogLevelNotice);
}

- (void)enableNetworkWithCompletion:(nullable void (^)(NSError *_Nullable error))completion {
  _firestore->EnableNetwork(util::MakeCallback(completion));
}

- (void)disableNetworkWithCompletion:(nullable void (^)(NSError *_Nullable))completion {
  _firestore->DisableNetwork(util::MakeCallback(completion));
}

- (void)clearPersistenceWithCompletion:(nullable void (^)(NSError *_Nullable error))completion {
  _firestore->ClearPersistence(util::MakeCallback(completion));
}

- (void)waitForPendingWritesWithCompletion:(void (^)(NSError *_Nullable error))completion {
  _firestore->WaitForPendingWrites(util::MakeCallback(completion));
}

- (void)terminateWithCompletion:(nullable void (^)(NSError *_Nullable error))completion {
  id<FSTFirestoreInstanceRegistry> strongRegistry = _registry;
  if (strongRegistry) {
    [strongRegistry
        removeInstanceWithDatabase:util::MakeNSString(_firestore->database_id().database_id())];
  }
  [self terminateInternalWithCompletion:completion];
}

- (id<FIRListenerRegistration>)addSnapshotsInSyncListener:(void (^)(void))listener {
  std::unique_ptr<core::EventListener<Empty>> eventListener =
      core::EventListener<Empty>::Create([listener](const StatusOr<Empty> &v) { listener(); });
  std::unique_ptr<ListenerRegistration> result =
      _firestore->AddSnapshotsInSyncListener(std::move(eventListener));
  return [[FSTListenerRegistration alloc] initWithRegistration:std::move(result)];
}

@end

@implementation FIRFirestore (Internal)

- (std::shared_ptr<Firestore>)wrapped {
  return _firestore;
}

- (const std::shared_ptr<util::AsyncQueue> &)workerQueue {
  return _firestore->worker_queue();
}

- (const DatabaseId &)databaseID {
  return _firestore->database_id();
}

+ (BOOL)isLoggingEnabled {
  return util::LogIsLoggable(util::kLogLevelDebug);
}

+ (FIRFirestore *)recoverFromFirestore:(std::shared_ptr<Firestore>)firestore {
  return (__bridge FIRFirestore *)firestore->extension();
}

- (void)terminateInternalWithCompletion:(nullable void (^)(NSError *_Nullable error))completion {
  _firestore->Terminate(util::MakeCallback(completion));
}

@end

NS_ASSUME_NONNULL_END
