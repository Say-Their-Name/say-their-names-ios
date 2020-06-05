//
//  Media.swift
//  SayTheirNames
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

protocol MediaInterface: Decodable {
    var url: String { get set }
}

public struct Media: MediaInterface, Hashable {
    var url: String

    enum CodingKeys: String, CodingKey {
        case url
    }
}
