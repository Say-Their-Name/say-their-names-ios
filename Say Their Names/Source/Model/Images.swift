//
//  Images.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

public struct Images: Decodable {
    var id: Int
    var personId: Int
    var imageUrl: String

    private enum CodingKeys: String, CodingKey {
        case id, personId = "person_id", imageUrl = "image_url"
    }
}
