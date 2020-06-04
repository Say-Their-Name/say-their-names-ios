//
//  AsyncOperation.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

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
