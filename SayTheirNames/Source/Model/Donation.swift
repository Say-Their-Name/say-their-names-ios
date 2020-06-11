//
//  Donation.swift
//  SayTheirNames
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

struct Donation: Decodable {
    let id: Int
    let identifier: String
    let title: String
    let description: String
    let outcome: String
    let link: String
    let outcomeImagePath: String
    let person: Person?
    let type: DonationType?
    let bannerImagePath: String
    let shareable: Shareable
    let hashtags: [Hashtag]
    
    private enum CodingKeys: String, CodingKey {
        case id, identifier, title, description, outcome, link, person, type
        case outcomeImagePath = "outcome_img_url", bannerImagePath = "banner_img_url", shareable = "sharable_links", hashtags = "hash_tags"
    }
    
    init(id: Int, identifier: String, title: String,
         description: String, outcome: String, link: String,
         outcomeImagePath: String, person: Person?, type: DonationType?,
         bannerImagePath: String, shareable: Shareable, hashtags: [Hashtag]) {
        self.id = id
        self.identifier = identifier
        self.title = title
        self.description = description
        self.outcome = outcome
        self.link = link
        self.outcomeImagePath = outcomeImagePath
        self.person = person
        self.type = type
        self.bannerImagePath = bannerImagePath
        self.shareable = shareable
        self.hashtags = hashtags
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.outcome = try container.decodeIfPresent(String.self, forKey: .outcome) ?? ""
        self.link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        self.outcomeImagePath = try container.decodeIfPresent(String.self, forKey: .outcomeImagePath) ?? ""
        self.person = try container.decodeIfPresent(Person.self, forKey: .person) ?? Person(from: decoder)
        self.type = try container.decodeIfPresent(DonationType.self, forKey: .type) ?? DonationType()
        self.bannerImagePath = try container.decodeIfPresent(String.self, forKey: .bannerImagePath) ?? ""
        self.shareable = try container.decodeIfPresent(Shareable.self, forKey: .shareable) ?? Shareable()
        self.hashtags = try container.decodeIfPresent([Hashtag].self, forKey: .hashtags) ?? []
    }
}

extension Donation: Hashable {}

extension Donation: CallToAction {
    var actionTitle: String {
        Strings.findOutMore
    }
    var body: String {
        description
    }
    var imagePath: String? {
        bannerImagePath
    }
    
    var tag: String? {
        type?.type.localizedUppercase
    }
}

struct DonationType: Codable {
    var id: Int = -1
    var type: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case id, type
    }
}

extension DonationType: Hashable {}

public struct DonationsResponsePage: Decodable {
    var all: [Donation]
    var link: Link
    
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
        
        self.all = try container.decodeIfPresent([Donation].self, forKey: .all) ?? []
        self.link = try container.decodeIfPresent(Link.self, forKey: .link) ?? Link(first: "", last: "", prev: "", next: "")
    }
}

struct DonationResponsePage: Decodable {
    let donation: Donation
    
    private enum CodingKeys: String, CodingKey {
        case donation = "data"
    }
}
