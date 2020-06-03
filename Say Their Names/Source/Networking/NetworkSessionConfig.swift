//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - NetworkSessionConfig
final class NetworkSessionConfig: NSObject {
    public var name: String = NetworkSessionConfigDefaults.name
    public var maxConcurrentOperationCount: Int = NetworkSessionConfigDefaults.maxConcurrentOperationCount
    public var timeoutIntervalForRequest: TimeInterval = NetworkSessionConfigDefaults.timeoutIntervalForRequest
    public lazy var sessionConfig: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = self.timeoutIntervalForRequest
        
        return config
    }()
    
    init(config: URLSessionConfiguration? = nil, name: String? = nil, maxConcurrentOperationCount: Int? = nil, timeoutIntervalForRequest: TimeInterval? = nil) {
        super.init()
        
        if let config = config { self.sessionConfig = config }
        if let name = name { self.name = name }
        if let maxConcurrentOperationCount = maxConcurrentOperationCount { self.maxConcurrentOperationCount = maxConcurrentOperationCount }
        if let timeoutIntervalForRequest = timeoutIntervalForRequest { self.timeoutIntervalForRequest = timeoutIntervalForRequest }
    }
}

// MARK: - NetworkSessionConfigDefaults
typealias NetworkSessionConfigDefaults = NetworkSessionConfig
extension NetworkSessionConfigDefaults {
    fileprivate static let name = "NetworkSession"
    fileprivate static let maxConcurrentOperationCount: Int = 5
    fileprivate static let timeoutIntervalForRequest: TimeInterval = 30.0
}
