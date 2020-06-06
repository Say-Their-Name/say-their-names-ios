//
//  PersonNetworkHandle.swift
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

// MARK: - PersonEnvironment
enum PersonEnvironment {
    static let baseUrlSring: String = { return "\(Environment.serverURLString)/api/people" }()
    static let peopleSearchString: String = { return "\(PersonEnvironment.baseUrlSring)/?name=" }()
    static let countrySeachUrlString: String = { return "\(PersonEnvironment.baseUrlSring)/?country=" }()
    static let citySeachUrlString: String = { return "\(PersonEnvironment.baseUrlSring)/?city=" }()
}

// MARK: - NetworkRequestor (People)
extension NetworkRequestor {
    // MARK: - Public methods
    
    public func fetchPeople(completion: @escaping (Result<PersonsResponsePage, AFError>) -> Swift.Void) {
        self.fetchDecodable(PersonEnvironment.baseUrlSring, completion: completion)
    }
    
    public func fetchPeopleWithLink(_ peopleLink: Link, completion: @escaping (Result<PersonsResponsePage, AFError>) -> Swift.Void) {
        guard let nextUrl = peopleLink.next else {
            let error = AFError.parameterEncodingFailed(reason: .missingURL)
            completion(.failure(error))
            return
        }
        
        self.fetchDecodable(nextUrl, completion: completion)
    }
    
    public func fetchPeopleByName(_ name: String, completion: @escaping (Result<PersonsResponsePage, AFError>) -> Swift.Void) {
        let url = "\(PersonEnvironment.peopleSearchString)\(name)"
        self.fetchDecodable(url, completion: completion)
    }
    
    public func fetchPeopleByCountry(_ country: String, completion: @escaping (Result<PersonsResponsePage, AFError>) -> Swift.Void) {
        let url = "\(PersonEnvironment.countrySeachUrlString)\(country)"
        self.fetchDecodable(url, completion: completion)
    }
    
    public func fetchPeopleByCity(_ city: String, completion: @escaping (Result<PersonsResponsePage, AFError>) -> Swift.Void) {
        let url = "\(PersonEnvironment.citySeachUrlString)\(city)"
        self.fetchDecodable(url, completion: completion)
    }
}
