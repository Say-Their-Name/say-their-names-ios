//
//  Donation.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

// MARK: - Donation
struct Donation: Codable {
    var id: String
    var title: String
    var description: String
    var link: String
    var person: Person
    var type: DonationType
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, link, person, type
    }
}

// MARK: - DonationType
struct DonationType: Codable {
    let id: String
    let type: String
}

