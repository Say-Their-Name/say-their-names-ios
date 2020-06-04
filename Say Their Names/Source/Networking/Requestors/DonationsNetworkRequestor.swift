//
//  DonationsNetworkRequestor.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

// MARK: - PetitionUrl
final class DonationsUrl: BaseNetworkUrl {
    class var donations: UrlString { return "\(self.base)/api/donations" }
}

// MARK: - DonationsNetworkRequestor
typealias DonationsNetworkRequestor = NetworkRequestor
extension DonationsNetworkRequestor {
    // MARK: - Public methods
    
    public func fetchDonations(completion: @escaping (Donations?) -> Swift.Void) {
        self.fetchDecodable(DonationsUrl.donations, completion: completion)
    }
}
