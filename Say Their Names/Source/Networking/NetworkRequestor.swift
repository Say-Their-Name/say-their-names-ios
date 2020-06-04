//
//  NetworkRequestor.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - NetworkRequestor

class NetworkRequestor: NSObject, ServiceReferring {
    let service: Service
    let concurrentQueue = DispatchQueue(label: "NetworkRequestor", attributes: .concurrent)
        
    required init(service: Service) {
        self.service = service
    }
    
    // MARK: - Public methods
    
    public func fetchDecodable<T: Decodable>(_ url: String, completion: @escaping (T?) -> Swift.Void) {
        let request = AF.request(url)
        request.responseDecodable(of: T.self, queue: self.concurrentQueue) { (response) in
            DispatchQueue.mainAsync { completion(response.value) }
        }
    }
    
    public func fetchData(_ url: String, completion: @escaping (Data?) -> Swift.Void) {
        let request = AF.request(url)
        request.responseData(queue: self.concurrentQueue) { (response) in
            DispatchQueue.mainAsync { completion(response.value) }
        }
    }
    
    
    public func fetchJson(_ url: String, completion: @escaping (Any?) -> Swift.Void) {
        let request = AF.request(url)
        request.responseJSON(queue: self.concurrentQueue) { (response) in
            DispatchQueue.mainAsync { completion(response.value) }
        }
    }
}
