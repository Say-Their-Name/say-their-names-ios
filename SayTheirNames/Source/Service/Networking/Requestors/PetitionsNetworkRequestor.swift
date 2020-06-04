//
//  PetitionsNetworkRequestor.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

// MARK: - PetitionUrl
final class PetitionUrl: BaseNetworkUrl {
    class var petition: UrlString { return "\(self.base)/api/petitions" }
}

// MARK: - PetitionNetworkRequestor
typealias PetitionNetworkRequestor = NetworkRequestor
extension PetitionNetworkRequestor {
    // MARK: - Public methods
    
    public func fetchPetitions(completion: @escaping (Petitions?) -> Swift.Void) {
        self.fetchDecodable(PetitionUrl.petition, completion: completion)
    }
}
