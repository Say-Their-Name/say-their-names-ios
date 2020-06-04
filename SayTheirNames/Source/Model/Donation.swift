//
//  Donation.swift
//  SayTheirNames
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
    var person: Person
    var type: DonationType
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, link, person, type
    }
}

struct DonationType: Codable {
    let id: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, type
    }
}

public struct DonationsResponsePage: Decodable {
    var all: [Donation]
    var link: Link
    
    enum CodingKeys: String, CodingKey {
        case all = "data", link = "links"
    }
    
    // Empty init
    init() {
        self.all = []
        self.link = Link(first: "", last: "", prev: "", next: "")
    }
}
