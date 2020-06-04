//
//  DonationsNetworkRequestor.swift
//  SayTheirNames
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - PetitionUrl
enum DonationsEnvironment {
    static let urlString: String = { return "\(Environment.serverURLString)/api/donations" }()
}

// MARK: - NetworkRequestor (Donations)
extension NetworkRequestor {
    // MARK: - Public methods
    
    public func fetchDonations(completion: @escaping (Result<DonationsResponsePage, AFError>) -> Swift.Void) {
        self.fetchDecodable(DonationsEnvironment.urlString, completion: completion)
    }
}
