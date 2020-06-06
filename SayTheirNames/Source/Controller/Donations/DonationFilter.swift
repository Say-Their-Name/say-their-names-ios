//
//  DonationFilter.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

enum DonationFilter {
    case all, businesses, protesters, victims
    
    var title: String {
        switch self {
        case .all:
            return Strings.filterAll
        case .businesses:
            return Strings.filterBusinesses
        case .protesters:
            return Strings.filterProtesters
        case .victims:
            return Strings.filterVictims
        }
    }
}

extension DonationFilter: FilterCategory {
    var name: String { title }
}
