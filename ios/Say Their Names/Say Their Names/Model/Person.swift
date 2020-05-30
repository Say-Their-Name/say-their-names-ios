//
//  Person.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

struct Person: Codable {
    var id: String
    var fullName: String
    var age: Int
    var childrenCount: Int
    var date: Date
    var location: String
    var media: [String]
    var bio: String
    var context: String
    var donations:[Donation]
    var petitions: [Petition]
    
    enum CodingKeys: String, CodingKey {
        case id, fullName = "full_name", age, childrenCount = "children_count",
        date, location, media, bio, context, donations, petitions
    }
}

