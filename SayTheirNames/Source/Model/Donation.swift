//
//  Donation.swift
//  SayTheirNames
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

public struct Donation: Decodable {
    let id: Int
    let title: String
    let description: String
    let link: String
    let person: Person
    let type: DonationType
    
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
