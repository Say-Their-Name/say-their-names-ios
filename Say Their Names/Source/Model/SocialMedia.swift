//
//  SocialMedia.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

public struct SocialMedia: Decodable {
    var title: String
    var type: String
    var link: String

    enum CodingKeys: String, CodingKey {
        case title, type, link
    }
}
