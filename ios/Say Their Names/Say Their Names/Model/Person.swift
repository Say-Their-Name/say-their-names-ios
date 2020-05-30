//
//  Person.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

struct Person: Codable {

    var id = String()
    var firstName: String?
    var lastName: String?
    var age: Int?
    var children: Int?
    var location: String?
    var media: [String]
    var bio: String?
    var context: String?
    var donations:[Donation]
    var petitions: [Petition]

    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.age = dictionary["age"] as? Int ?? 0
        self.children = dictionary["children"] as? Int ?? 0
        self.media = dictionary["media"] as? [String] ?? []
        self.bio = dictionary["bio"] as? String ?? ""
        self.context = dictionary["context"] as? String ?? ""
        self.donations = dictionary["donations"] as? [Donation] ?? []
        self.petitions = dictionary["petitions"] as? [Petition] ?? []
    }
}
