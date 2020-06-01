//
//  Person.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Person: Codable {
    let name: String
    let age: Int
    let numberOfChildren: Int
    
    // TODO: ensure what timezone dates are in
    let dateOfIncident: Date
    let dateOfBirth: Date

    let location: DocumentReference
    
//    let media: [String]
    let picture: String
    let bio: String
    let context: String
    let donations: [DocumentReference]
    let petitions: [DocumentReference]
    
    enum CodingKeys: String, CodingKey {
        case /*id,*/ name , age, numberOfChildren = "number_of_children", dateOfBirth = "date_of_birth", 
        dateOfIncident = "date_of_incident", picture, location, /*media,*/ bio, context, donations, petitions
    }
}

