//
//  DonationFilter.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

enum DonationFilter {
    case all, businesses, victims, protesters
    
    var title: String {
        switch self {
        case .all:
            return "ALL"
        case .businesses:
            return "BUSINESSES"
        case .victims:
            return "VICTIMS"
        case .protesters:
            return "PROTESTERS"
        }
    }
}
