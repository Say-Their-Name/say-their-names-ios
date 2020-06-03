//
//  Images.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

protocol ImagesInterface: Decodable {
    var id: Int { get set }
    var personId: Int { get set }
    var imageUrl: String { get set }
}

public struct Images: ImagesInterface {
    var id: Int
    var personId: Int
    var imageUrl: String

    private enum CodingKeys: String, CodingKey {
        case id, personId = "person_id", imageUrl = "image_url"
    }
}
