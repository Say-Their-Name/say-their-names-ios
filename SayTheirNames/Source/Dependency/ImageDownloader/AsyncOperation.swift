//
//  AsyncOperation.swift
//  SayTheirNames
//
//  Copyright (c) 2020 Say Their Names Team (https://github.com/Say-Their-Name)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

/// An asynchronous operation that manges its own state and
/// triggers KVO events internally
class AsyncOperation: Operation {
    override var isAsynchronous: Bool {
        true
    }
    
    override var isExecuting: Bool {
        state == .executing
    }
    
    override var isFinished: Bool {
        state == .finished
    }
    
    override var isReady: Bool {
        super.isReady && state == .ready
    }
    
    /// The internal state of the operation which can be updated
    /// to trigger KVO events
    var state = State.ready {
        willSet (newState) {
            willChangeValue(forKey: newState.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet (oldState) {
            didChangeValue(forKey: oldState.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    override func start() {
        // Check if the operation is cancelled
        guard isNotCancelled else {
            // Ensure that `state` is set to `finished`
            state = .finished
            return
        }
        
        // Execute main operation functionality
        main()
        
        // Update state to executing for KVO
        state = .executing
    }
    
    /// Updates the state to `finished`, thus triggering KVO
    /// and stoping any other work for the operation
    override func cancel() {
        state = .finished
    }
}

extension AsyncOperation {
    /// The possible stages of the operation
    enum State {
        case executing, finished, ready
        
        /// String representation of the Operataion KVO keyPath
        var keyPath: String {
            switch self {
            case .executing:
                return "isExecuting"
            case .finished:
                return "isFinished"
            case .ready:
                return "isReady"
            }
        }
    }
}
