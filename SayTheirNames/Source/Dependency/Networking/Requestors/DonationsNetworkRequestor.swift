//
//  DonationsNetworkRequestor.swift
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
import Alamofire

// MARK: - PetitionUrl
enum DonationsEnvironment {
    static let baseURLString: String = { return "\(Environment.serverURLString)/api/donations" }()
}

// MARK: - NetworkRequestor (Donations)
extension NetworkRequestor {
    // MARK: - Public methods
    
    public func fetchDonations(completion: @escaping (Result<DonationsResponsePage, Swift.Error>) -> Swift.Void) {
        self.fetchDecodable(DonationsEnvironment.baseURLString, completion: completion)
    }
    
    public func fetchDonations(with link: Link, completion: @escaping (Result<DonationsResponsePage, Swift.Error>) -> Swift.Void) {
        guard let nextUrl = link.next else {
            let error = AFError.parameterEncodingFailed(reason: .missingURL)
            completion(.failure(error))
            return
        }
        
        self.fetchDecodable(nextUrl, completion: completion)
    }
    
    public func fetchDonationsByPersonName(_ name: String, completion: @escaping (Result<DonationsResponsePage, Swift.Error>) -> Swift.Void) {
        guard let components = URLComponents(string: DonationsEnvironment.baseURLString, item: URLQueryItem(name: "name", value: name)),
              let urlString = components.url?.absoluteString
        else {
            let error = AFError.parameterEncodingFailed(reason: .missingURL)
            completion(.failure(error))
            return
        }
        
        self.fetchDecodable(urlString, completion: completion)
    }
    
    public func fetchDonationsByType(_ type: String, completion: @escaping (Result<DonationsResponsePage, Swift.Error>) -> Swift.Void) {
        guard let components = URLComponents(string: DonationsEnvironment.baseURLString, item: URLQueryItem(name: "type", value: type)),
              let urlString = components.url?.absoluteString
        else {
            let error = AFError.parameterEncodingFailed(reason: .missingURL)
            completion(.failure(error))
            return
        }
        
        self.fetchDecodable(urlString, completion: completion)
    }
    
    public func fetchDonationDetails(with identifier: String, completion: @escaping (Result<DonationResponsePage, Swift.Error>) -> Swift.Void) {
        self.fetchDecodable(DonationsEnvironment.baseURLString + "/" + identifier, completion: completion)
    }
}
