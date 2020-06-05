//
//  PeopleLink.swift
//  SayTheirNames
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

public struct Link: Decodable, Hashable {
    var first: String
    var last: String
    var prev: String?
    var next: String?
    
    private enum CodingKeys: String, CodingKey {
        case first, last, prev, next
    }
}
