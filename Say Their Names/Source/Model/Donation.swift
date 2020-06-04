//
//  Donation.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

public struct Donation: Decodable {
    var id: Int
    var title: String
    var description: String
    var link: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, link
    }
}

public struct Donations: Decodable {
    var all: [Donation]
    var link: Link
    
    enum CodingKeys: String, CodingKey {
        case all = "data", link = "links"
    }
}
