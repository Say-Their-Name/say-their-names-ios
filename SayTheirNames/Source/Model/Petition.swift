//
//  Petition.swift
//  SayTheirNames
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

public struct Petition: Decodable {
    let id: Int
    let title: String
    let description: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, link
    }
}

public struct PetitionsResponsePage: Decodable {
    let all: [Petition]
    let link: Link
    
    enum CodingKeys: String, CodingKey {
        case all = "data", link = "links"
    }
    
    // Empty init
    init() {
        self.all = []
        self.link = Link(first: "", last: "", prev: "", next: "")
    }
}
