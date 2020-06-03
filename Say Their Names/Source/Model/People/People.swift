//
//  People.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

public struct People: Decodable {
    var people: Array<Person>?
    var links: PeopleLink?
    
    private enum CodingKeys: String, CodingKey {
        case people = "data", links
    }
}
