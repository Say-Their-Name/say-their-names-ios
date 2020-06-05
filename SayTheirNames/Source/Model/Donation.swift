//
//  Donation.swift
//  SayTheirNames
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

public struct Donation: Decodable, Hashable {
    var id: Int
    var title: String
    var description: String
    var link: String
    var person: Person
    var type: DonationType
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, link, person, type
    }
    
    public static func == (lhs: Donation, rhs: Donation) -> Bool {
        lhs.id == rhs.id
    }
}

struct DonationType: Codable, Hashable {
    let id: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, type
    }
    
    public static func == (lhs: DonationType, rhs: DonationType) -> Bool {
        lhs.id == rhs.id
    }
}

public struct DonationsResponsePage: Decodable, Hashable {
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
    
    public static func == (lhs: DonationsResponsePage, rhs: DonationsResponsePage) -> Bool {
        lhs.all == rhs.all
    }
}
