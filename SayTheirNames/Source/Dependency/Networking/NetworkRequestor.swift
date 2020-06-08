//
//  NetworkRequestor.swift
//  Say Their Names
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
import Alamofire

// MARK: - NetworkRequestor
final class NetworkRequestor: Dependency {
    let session: Session
    let concurrentQueue = DispatchQueue(label: "NetworkRequestor", attributes: .concurrent)
    private let headers = HTTPHeaders.init(["x-dates-epoch": "true"])
    
    init(session: Session = .default) {
        self.session = session
    }
    
    // MARK: - Public methods
    
    public func fetchDecodable<T: Decodable>(_ url: String, completion: @escaping (Result<T, Swift.Error>) -> Swift.Void) {
        let request = self.session.request(url, headers: self.headers)
        request.responseDecodable(of: T.self, queue: self.concurrentQueue) { (response) in
            DispatchQueue.mainAsync { completion(response.result.mapError({$0.swiftError})) }
        }
    }
    
    public func fetchData(_ url: String, completion: @escaping (Result<Data, Swift.Error>) -> Swift.Void) {
        let request = self.session.request(url, headers: self.headers)
        request.responseData(queue: self.concurrentQueue) { (response) in
            completion(response.result.mapError({$0.swiftError}))
        }
    }
    
    public func fetchJSON(_ url: String, completion: @escaping (Result<Any, Swift.Error>) -> Swift.Void) {
        let request = self.session.request(url, headers: self.headers)
        request.responseJSON(queue: self.concurrentQueue) { (response) in
            completion(response.result.mapError({$0.swiftError}))
        }
    }
}
// MARK: - AFError + swiftError
extension AFError {
    var swiftError: Error {
        return self as Swift.Error
    }
}
