//
//  Person.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

protocol PersonInterface: Decodable {
    var id: Int { get set }
    var fullName: String? { get set }
    var dob: String? { get set }
    var doi: String? { get set }
    var childrenCount: String? { get set }
    var age: String? { get set }
    var city: String? { get set }
    var country: String? { get set }
    var bio: String? { get set }
    var context: String? { get set }
    var images: [Images]? { get set }
}

public struct Person: PersonInterface {
    var id: Int = -1
    var fullName: String?
    var dob: String?
    var doi: String?
    var childrenCount: String?
    var age: String?
    var city: String?
    var country: String?
    var bio: String?
    var context: String?
    var images: [Images]?
    
    private enum CodingKeys: String, CodingKey {
        case id, fullName = "full_name", dob = "date_of_birth", doi = "date_of_incident", childrenCount = "number_of_children",
        age, city, country, bio, context, images
    }
    
    
}
