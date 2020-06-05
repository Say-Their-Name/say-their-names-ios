//
//  Location.swift
//  SayTheirNames
//
//  Created by Marina Gornostaeva on 01/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

struct Location: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

extension Location: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
