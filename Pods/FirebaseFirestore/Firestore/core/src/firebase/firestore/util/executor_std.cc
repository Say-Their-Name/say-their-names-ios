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

#include "Firestore/core/src/firebase/firestore/util/executor_std.h"

#include <future>  // NOLINT(build/c++11)
#include <memory>
#include <sstream>

#include "absl/memory/memory.h"

namespace firebase {
namespace firestore {
namespace util {

namespace {

// The only guarantee is that different `thread_id`s will produce different
// values.
std::string ThreadIdToString(const std::thread::id thread_id) {
  std::ostringstream stream;
  stream << thread_id;
  return stream.str();
}

}  // namespace

// MARK: - ExecutorStd

ExecutorStd::ExecutorStd(int threads) {
  HARD_ASSERT(threads > 0);

  // Somewhat counter-intuitively, constructor of `std::atomic` assigns the
  // value non-atomically, so the atomic initialization must be provided here,
  // before the worker thread is started.
  // See [this thread](https://stackoverflow.com/questions/25609858) for context
  // on the constructor.
  current_id_ = 0;
  shutting_down_ = false;
  for (int i = 0; i < threads; ++i) {
    worker_thread_pool_.emplace_back(&ExecutorStd::PollingThread, this);
  }
}

ExecutorStd::~ExecutorStd() {
  shutting_down_ = true;

  // Make sure the worker threads are not blocked, so that the call to `join`
  // doesn't hang. It's not deterministic which thread will pick up an entry,
  // so add an entry for each thread before attempting to join.
  for (size_t i = 0; i < worker_thread_pool_.size(); ++i) {
    UnblockQueue();
  }

  for (std::thread& thread : worker_thread_pool_) {
    thread.join();
  }
}

void ExecutorStd::Execute(Operation&& operation) {
  PushOnSchedule(std::move(operation), Immediate());
}

DelayedOperation ExecutorStd::Schedule(const Milliseconds delay,
                                       TaggedOperation&& tagged) {
  // While negative delay can be interpreted as a request for immediate
  // execution, supporting it would provide a hacky way to modify FIFO ordering
  // of immediate operations.
  HARD_ASSERT(delay.count() >= 0, "Schedule: delay cannot be negative");

  namespace chr = std::chrono;
  const auto now = chr::time_point_cast<Milliseconds>(chr::steady_clock::now());
  const auto id =
      PushOnSchedule(std::move(tagged.operation), now + delay, tagged.tag);

  return DelayedOperation{[this, id] { TryCancel(id); }};
}

void ExecutorStd::TryCancel(const Id operation_id) {
  schedule_.RemoveIf(
      [operation_id](const Entry& e) { return e.id == operation_id; });
}

ExecutorStd::Id ExecutorStd::PushOnSchedule(Operation&& operation,
                                            const TimePoint when,
                                            const Tag tag) {
  // Note: operations scheduled for immediate execution don't actually need an
  // id. This could be tweaked to reuse the same id for all such operations.
  const auto id = NextId();
  schedule_.Push(Entry{std::move(operation), id, tag}, when);
  return id;
}

void ExecutorStd::PollingThread() {
  while (!shutting_down_) {
    Entry entry = schedule_.PopBlocking();
    if (entry.tagged.operation) {
      entry.tagged.operation();
    }
  }
}

void ExecutorStd::UnblockQueue() {
  // Put a no-op for immediate execution on the queue to ensure that
  // `schedule_.PopBlocking` returns, and worker thread can notice that shutdown
  // is in progress.
  schedule_.Push(Entry{[] {}, /*id=*/0}, Immediate());
}

ExecutorStd::Id ExecutorStd::NextId() {
  // The wrap around after ~4 billion operations is explicitly ignored. Even if
  // an instance of `ExecutorStd` runs long enough to get `current_id_` to
  // overflow, it's extremely unlikely that any object still holds a reference
  // that is old enough to cause a conflict.
  return current_id_++;
}

bool ExecutorStd::IsCurrentExecutor() const {
  auto current_id = std::this_thread::get_id();
  for (const std::thread& thread : worker_thread_pool_) {
    if (thread.get_id() == current_id) {
      return true;
    }
  }
  return false;
}

std::string ExecutorStd::CurrentExecutorName() const {
  if (IsCurrentExecutor()) {
    return Name();
  } else {
    return ThreadIdToString(std::this_thread::get_id());
  }
}

std::string ExecutorStd::Name() const {
  return ThreadIdToString(worker_thread_pool_.front().get_id());
}

void ExecutorStd::ExecuteBlocking(Operation&& operation) {
  std::promise<void> signal_finished;
  Execute([&] {
    operation();
    signal_finished.set_value();
  });
  signal_finished.get_future().wait();
}

bool ExecutorStd::IsScheduled(const Tag tag) const {
  return schedule_.Contains(
      [&tag](const Entry& e) { return e.tagged.tag == tag; });
}

absl::optional<Executor::TaggedOperation> ExecutorStd::PopFromSchedule() {
  auto removed =
      schedule_.RemoveIf([](const Entry& e) { return !e.IsImmediate(); });
  if (!removed.has_value()) {
    return {};
  }
  return {std::move(removed.value().tagged)};
}

// MARK: - Executor

// Only defined on non-Apple platforms. On Apple platforms, see the alternative
// definition in executor_libdispatch.mm.
#if !__APPLE__

std::unique_ptr<Executor> Executor::CreateSerial(const char*) {
  return absl::make_unique<ExecutorStd>(/*threads=*/1);
}

std::unique_ptr<Executor> Executor::CreateConcurrent(const char*, int threads) {
  return absl::make_unique<ExecutorStd>(threads);
}

#endif  // !__APPLE__

}  // namespace util
}  // namespace firestore
}  // namespace firebase
