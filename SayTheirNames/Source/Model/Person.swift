//
//  Person.swift
//  Say Their Names
//
//  Copyright (c) 2020 Say Their Names Team (https://github.com/Say-Their-Name)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

struct Person: Decodable {
    let id: Int
    let fullName: String
    let dob: String
    let doi: String
    let childrenCount: String
    let age: String
    let city: String
    let country: String
    let bio: String
    let context: String
    let images: [Image]
    let donations: DonationsResponsePage
    let petitions: PetitionsResponsePage
    let media: [Media]
    let socialMedia: [SocialMedia]
    
    private enum CodingKeys: String, CodingKey {
        case id, fullName = "full_name", dob = "date_of_birth", doi = "date_of_incident", childrenCount = "number_of_children",
        age, city, country, bio, context, images, donations = "donation_links", petitions = "petition_links", media = "media_links",
        socialMedia = "social_media"
    }
    
    init(from decoder: Decoder) throws {
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

struct PersonsResponsePage: Decodable {
    let all: [Person]
    let link: Link
    
    private enum CodingKeys: String, CodingKey {
        case all = "data", link = "links"
    }
    
    // Empty init
    init() {
        self.all = []
        self.link = Link(first: "", last: "", prev: "", next: "")
    }
}

extension Person: Equatable, Hashable {
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
