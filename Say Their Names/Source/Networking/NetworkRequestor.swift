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
    weak var service: Service?
    let concurrentQueue = DispatchQueue(label: "NetworkRequestor", attributes: .concurrent)
        
    required init(service: Service) {
        self.service = service
    }
    
    // MARK: - Public methods
    
    public func fetch<T: Decodable>(_ url: String, completion: @escaping (T?) -> Swift.Void) {
        let request = AF.request(url)
        request.responseDecodable(of: T.self, queue: self.concurrentQueue) { (response) in
            DispatchQueue.mainAsync { completion(response.value) }
        }
    }
}
