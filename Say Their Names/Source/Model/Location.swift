//
//  Location.swift
//  Say Their Names
//
//  Created by Marina Gornostaeva on 01/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

struct Location: Codable {
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
