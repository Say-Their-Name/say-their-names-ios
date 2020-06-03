//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//
import UIKit

// MARK: - NetworkSession
final class NetworkSession<T>: NSObject {
    public weak var service: Service!
    public var sessionConfig: NetworkSessionConfig
    
    fileprivate lazy var session: URLSession = URLSession(configuration: self.sessionConfig.sessionConfig, delegate: nil, delegateQueue: self.operationQueue)
    fileprivate lazy var operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = self.sessionConfig.name
        queue.maxConcurrentOperationCount = self.sessionConfig.maxConcurrentOperationCount
        
        return queue
    }()
    
    override init() {
        self.sessionConfig = NetworkSessionConfig()
        super.init()
        
        Log.print("Starting NetworkSession")
    }
    
    init(config: NetworkSessionConfig) {
        self.sessionConfig = config
        super.init()
        
        Log.print("Starting NetworkSession")
    }
    
    public func load<T>(_ download: NetworkTask<T>, completion: @escaping (T?, TimeInterval, NetworkError?) -> Swift.Void) {
        // Start network indicator
        self._handleNetworkActivityIndicator()
        
        // Start timer
        let time = Date()

        // Check that are request is valid
       guard let request = download.urlRequest else {
           completion(nil, 0, nil)
           return
       }
       
       // Handle request function
       let handleRequest = { [weak self] in
           // Add api token
           //request.addApiHeader(fromSession: self?.service.apiSession)
           
           // Log the request
           Log.print(request.debugString)
           
           // Build the url session task
           download.urlSessionTask = self?.session.dataTask(with: request) { [weak self, download] in
               // Handle activity indicator
               self?._handleNetworkActivityIndicator()

               // Parse
               let (result, networkError) = download.parse($0, $2, $1)

               // Return
               completion(result, Date().timeIntervalSince(time), networkError)
           }
           
           self?._start(task: download.urlSessionTask)
       }
       
       // Check if the request needs authorization
       if download.authRequired {
           //self?.service.userSession.checkSession { (auth, error) in
               // Add auth token
               //request.addAuthHeader(fromAuth: auth)
               
               // Handle request
               handleRequest()
           //}
       }
       else {
           // Handle request
           handleRequest()
       }
    }
}

fileprivate extension NetworkSession {
    func _handleNetworkActivityIndicator() {
        self.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            DispatchQueue.mainAsync {
                let makeVisible = dataTasks.count > 0 || uploadTasks.count > 0 || downloadTasks.count > 0
                UIApplication.shared.isNetworkActivityIndicatorVisible = makeVisible
            }
        }
    }
    
    func _start(task: URLSessionTask?) {
        guard let task = task else { return }
        
        task.resume()
        self._handleNetworkActivityIndicator()
    }
}
