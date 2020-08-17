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

import UIKit

struct Person: Decodable {
    let id: Int
    let fullName: String
    let identifier: String
    let doi: Date
    let childrenCount: Int?
    let age: Int?
    let city: String
    let country: String
    let story: String
    let outcome: String
    let biography: String
    let shareable: Shareable
    let images: [Image]
    let donations: [Donation]
    let petitions: [Petition]
    let medias: [Media]
    let news: [News]
    let socialMedia: [SocialMedia]
    let hashtags: [Hashtag]
    
    private enum CodingKeys: String, CodingKey {
        case id, fullName = "full_name", identifier, doi = "date_of_incident",
        childrenCount = "number_of_children", age, city, country, story = "their_story",
        biography, outcome, shareable = "sharable_links", images, donations = "donation_links",
        petitions = "petition_links", medias = "media", news, socialMedia = "social_media", hashtags = "hash_tags"
    }
    
    init(id: Int, fullName: String, identifier: String,
         doi: Date, childrenCount: Int?, age: Int?, city: String,
         country: String, story: String, biography: String, outcome: String,
         shareable: Shareable, images: [Image], donations: [Donation], petitions: [Petition], medias: [Media],
         news: [News], socialMedia: [SocialMedia], hashtags: [Hashtag]
    ) {
        self.id = id
        self.fullName = fullName
        self.identifier = identifier
        self.doi = doi
        self.childrenCount = childrenCount
        self.age = age
        self.city = city
        self.country = country
        self.story = story
        self.outcome = outcome
        self.shareable = shareable
        self.images = images
        self.donations = donations
        self.petitions = petitions
        self.medias = medias
        self.news = news
        self.socialMedia = socialMedia
        self.hashtags = hashtags
        self.biography = biography
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName) ?? ""
        self.identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
        self.childrenCount = try container.decodeIfPresent(Int.self, forKey: .childrenCount)
        self.age = try container.decodeIfPresent(Int.self, forKey: .age)
        self.city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        self.country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
        self.story = try container.decodeIfPresent(String.self, forKey: .story) ?? ""
        self.outcome = try container.decodeIfPresent(String.self, forKey: .outcome) ?? ""
        self.biography = try container.decodeIfPresent(String.self, forKey: .biography) ?? ""
        self.shareable =  try container.decodeIfPresent(Shareable.self, forKey: .shareable) ?? Shareable()
        
        self.images = try container.decodeIfPresent([Image].self, forKey: .images) ?? []
        self.donations = try container.decodeIfPresent([Donation].self, forKey: .donations) ?? []
        self.petitions = try container.decodeIfPresent([Petition].self, forKey: .petitions) ?? []
        self.medias = try container.decodeIfPresent([Media].self, forKey: .medias) ?? []
        self.news = try container.decodeIfPresent([News].self, forKey: .news) ?? []
        self.socialMedia = try container.decodeIfPresent([SocialMedia].self, forKey: .socialMedia) ?? []
        self.hashtags = try container.decodeIfPresent([Hashtag].self, forKey: .hashtags) ?? []

        let doi = try container.decodeIfPresent(TimeInterval.self, forKey: .doi) ?? 0
        self.doi = Date(timeIntervalSince1970: doi)
    }
}

extension Person: SearchResult {
    var image: UIImage? {
        nil // STNAsset.Image.userCircle.image
    }
    
    var title: String {
        fullName
    }
    
    var subtitle: String? {
        nil
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

struct PersonResponsePage: Decodable {
    let person: Person
    
    private enum CodingKeys: String, CodingKey {
        case person = "data"
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
