//
//  Person.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

public struct Person: Decodable {
    var id: Int
    var fullName: String
    var dob: String
    var doi: String
    var childrenCount: String
    var age: String
    var city: String
    var country: String
    var bio: String
    var context: String
    var images: [Image]
    var donations: DonationsResponsePage
    var petitions: PetitionsResponsePage
    var media: [Media]
    var socialMedia: [SocialMedia]
    
    private enum CodingKeys: String, CodingKey {
        case id, fullName = "full_name", dob = "date_of_birth", doi = "date_of_incident", childrenCount = "number_of_children",
        age, city, country, bio, context, images, donations = "donation_links", petitions = "petition_links", media = "media_links",
        socialMedia = "social_media"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.fullName = try values.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        self.dob = try values.decodeIfPresent(String.self, forKey: .dob) ?? ""
        self.doi = try values.decodeIfPresent(String.self, forKey: .doi) ?? ""
        self.childrenCount = try values.decodeIfPresent(String.self, forKey: .childrenCount) ?? "0"
        self.age = try values.decodeIfPresent(String.self, forKey: .age) ?? ""
        self.city = try values.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.country = try values.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.bio = try values.decodeIfPresent(String.self, forKey: .bio) ?? ""
        self.context = try values.decodeIfPresent(String.self, forKey: .context) ?? ""
        
        self.images = try values.decodeIfPresent([Image].self, forKey: .images) ?? []
        self.donations = try values.decodeIfPresent(DonationsResponsePage.self, forKey: .donations) ?? DonationsResponsePage()
        self.petitions = try values.decodeIfPresent(PetitionsResponsePage.self, forKey: .petitions) ?? PetitionsResponsePage()
        self.media = try values.decodeIfPresent([Media].self, forKey: .media) ?? []
        self.socialMedia = try values.decodeIfPresent([SocialMedia].self, forKey: .socialMedia) ?? []
    }    
}

public struct PersonsResponsePage: Decodable {
    var all: [Person]
    var link: Link
    
    private enum CodingKeys: String, CodingKey {
        case all = "data", link = "links"
    }
    
    // Empty init
    init() {
        self.all = []
        self.link = Link(first: "", last: "", prev: "", next: "")
    }
}
