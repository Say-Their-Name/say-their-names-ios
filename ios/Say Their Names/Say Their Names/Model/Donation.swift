//
//  Donation.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

struct Donation: Codable {

    var title = String()
    var description: String?
    var link: String?

    init(dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.link = dictionary["link"] as? String ?? ""
    }
}

