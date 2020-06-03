//
//  PeopleLink.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

protocol PeopleLinkInterface: Decodable {
    var first: String { get set }
    var last: String { get set }
    var prev: String? { get set }
    var next: String? { get set }
}

public struct PeopleLink: PeopleLinkInterface {
    var first: String
    var last: String
    var prev: String?
    var next: String?
    
    private enum CodingKeys: String, CodingKey {
        case first, last, prev, next
    }
}
