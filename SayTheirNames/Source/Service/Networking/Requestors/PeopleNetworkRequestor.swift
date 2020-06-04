//
//  PersonNetworkHandle.swift
//  SayTheirNames
//
//  Created by evilpenguin on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - PersonEnvironment
enum PersonEnvironment {
    static let urlString: String = { return "\(Environment.serverURLString)/api/people" }()
}

// MARK: - NetworkRequestor (People)
extension NetworkRequestor {
    // MARK: - Public methods
    
    public func fetchPeople(completion: @escaping (Result<PersonsResponsePage, AFError>) -> Swift.Void) {
        self.fetchDecodable(PersonEnvironment.urlString, completion: completion)
    }
    
    public func fetchPeopleWithLink(_ peopleLink: Link, completion: @escaping (Result<PersonsResponsePage, AFError>) -> Swift.Void) {
        guard let nextUrl = peopleLink.next else {
            let error = AFError.parameterEncodingFailed(reason: .missingURL)
            completion(.failure(error))
            return
        }
        
        self.fetchDecodable(nextUrl, completion: completion)
    }
}
