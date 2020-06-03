//
//  People.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

protocol PeopleInterface: Decodable {
    var people: Array<Person>? { get set }
    var links: PeopleLink?  { get set }
}

public struct People: PeopleInterface {
    var people: Array<Person>?
    var links: PeopleLink?
    
    private enum CodingKeys: String, CodingKey {
        case people = "data", links
    }
}
