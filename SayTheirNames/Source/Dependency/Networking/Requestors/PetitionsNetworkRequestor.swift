//
//  PetitionsNetworkRequestor.swift
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

// MARK: - PetitionEnvironment
enum PetitionEnvironment {
    static let baseURLString: String = { return "\(Environment.serverURLString)/api/petitions" }()
    static let petitionsSearchString: String = { return "\(DonationsEnvironment.baseURLString)/?name=" }()
    static let petitionsTypeSearchString: String = { return "\(DonationsEnvironment.baseURLString)/?type=" }()
}

// MARK: - NetworkRequestor (Petition)
extension NetworkRequestor {
    // MARK: - Public methods
    
    public func fetchPetitions(completion: @escaping (Result<PetitionsResponsePage, Swift.Error>) -> Swift.Void) {
        self.fetchDecodable(PetitionEnvironment.baseURLString, completion: completion)
    }
    
    public func fetchPetitionsByPersonName(_ name: String, completion: @escaping (Result<DonationsResponsePage, Swift.Error>) -> Swift.Void) {
        let url = "\(PetitionEnvironment.petitionsSearchString)\(name)"
        self.fetchDecodable(url, completion: completion)
    }
    
    public func fetchPetitionsByType(_ type: String, completion: @escaping (Result<DonationsResponsePage, Swift.Error>) -> Swift.Void) {
        let url = "\(PetitionEnvironment.petitionsTypeSearchString)\(type)"
        self.fetchDecodable(url, completion: completion)
    }
}
