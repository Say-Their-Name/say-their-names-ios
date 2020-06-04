//
//  Donation.swift
//  SayTheirNames
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

struct Donation: Codable {
    var title: String
    var description: String
    var link: String
    
    enum CodingKeys: String, CodingKey {
        case title, description, link
    }
}

