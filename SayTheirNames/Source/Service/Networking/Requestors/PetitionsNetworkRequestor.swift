//
//  PetitionsNetworkRequestor.swift
//  SayTheirNames
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - PetitionEnvironment
enum PetitionEnvironment {
    static let urlString: String = { return "\(Environment.serverURLString)/api/petitions" }()
}

// MARK: - NetworkRequestor (Petition)
extension NetworkRequestor {
    // MARK: - Public methods
    
    public func fetchPetitions(completion: @escaping (Result<PetitionsResponsePage, AFError>) -> Swift.Void) {
        self.fetchDecodable(PetitionEnvironment.urlString, completion: completion)
    }
}
