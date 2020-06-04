//
//  PetitionsNetworkRequestor.swift
//  SayTheirNames
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

// MARK: - PetitionEnvironment
enum PetitionEnvironment {
    static let urlString: String = { return "\(Environment.serverURLString)/api/petitions" }()
}

// MARK: - NetworkRequestor (Petition)
extension NetworkRequestor {
    // MARK: - Public methods
    
    public func fetchPetitions(completion: @escaping (PetitionsResponsePage?) -> Swift.Void) {
        self.fetchDecodable(PetitionEnvironment.urlString, completion: completion)
    }
}
