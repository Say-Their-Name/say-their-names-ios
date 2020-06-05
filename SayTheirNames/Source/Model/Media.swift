//
//  Media.swift
//  SayTheirNames
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

public struct Media: Decodable {
    let url: String

    enum CodingKeys: String, CodingKey {
        case url
    }
}
