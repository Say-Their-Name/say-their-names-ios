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

final class NetworkRequestor {
    let concurrentQueue = DispatchQueue(label: "NetworkRequestor", attributes: .concurrent)
    let session: Session

    init(session: Session = .default) {
        self.session = session
    }
    
    // MARK: - Public methods
    
    public func fetchDecodable<T: Decodable>(_ url: String, completion: @escaping (Result<T, AFError>) -> Swift.Void) {
        let request = session.request(url)
        request.responseDecodable(of: T.self, queue: self.concurrentQueue) { (response) in
            DispatchQueue.mainAsync { completion(response.result) }
        }
    }
    
    public func fetchData(_ url: String, completion: @escaping (Result<Data, AFError>) -> Swift.Void) {
        let request = session.request(url)
        request.responseData(queue: self.concurrentQueue) { (response) in
            DispatchQueue.mainAsync { completion(response.result) }
        }
    }
    
    public func fetchJson(_ url: String, completion: @escaping (Result<Any, AFError>) -> Swift.Void) {
        let request = session.request(url)
        request.responseJSON(queue: self.concurrentQueue) { (response) in
            DispatchQueue.mainAsync { completion(response.result) }
        }
    }
}
