//
//  Images.swift
//  SayTheirNames
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

public struct Image: Decodable {
    var id: Int
    var personID: Int
    var personURL: String

    private enum CodingKeys: String, CodingKey {
        case id, personID = "person_id", personURL = "image_url"
    }
}
