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
    
    init(id: Int, fullName: String, dob: String,
         doi: String, childrenCount: String, age: String,
         city: String, country: String, bio: String,
         context: String, images: [Image], donations: DonationsResponsePage,
         petitions: PetitionsResponsePage, media: [Media], socialMedia: [SocialMedia]) {
        self.id = id
        self.fullName = fullName
        self.dob = dob
        self.doi = doi
        self.childrenCount = childrenCount
        self.age = age
        self.city = city
        self.country = country
        self.bio = bio
        self.context = context
        self.images = images
        self.donations = donations
        self.petitions = petitions
        self.media = media
        self.socialMedia = socialMedia
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        self.dob = try container.decodeIfPresent(String.self, forKey: .dob) ?? ""
        self.doi = try container.decodeIfPresent(String.self, forKey: .doi) ?? ""
        self.childrenCount = try container.decodeIfPresent(String.self, forKey: .childrenCount) ?? "0"
        self.age = try container.decodeIfPresent(String.self, forKey: .age) ?? ""
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio) ?? ""
        self.context = try container.decodeIfPresent(String.self, forKey: .context) ?? ""
        
        self.images = try container.decodeIfPresent([Image].self, forKey: .images) ?? []
        self.donations = try container.decodeIfPresent(DonationsResponsePage.self, forKey: .donations) ?? DonationsResponsePage()
        self.petitions = try container.decodeIfPresent(PetitionsResponsePage.self, forKey: .petitions) ?? PetitionsResponsePage()
        self.media = try container.decodeIfPresent([Media].self, forKey: .media) ?? []
        self.socialMedia = try container.decodeIfPresent([SocialMedia].self, forKey: .socialMedia) ?? []
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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.all = try container.decodeIfPresent([Person].self, forKey: .all) ?? []
        self.link = try container.decodeIfPresent(Link.self, forKey: .link) ?? Link(first: "", last: "", prev: "", next: "")
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

extension Person {
    
}
