//
//  Donation.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

protocol DonationInterface: Decodable {
    var id: Int { get set }
    var title: String { get set }
    var description: String { get set }
    var link: String { get set }
}

public struct Donation: DonationInterface {
    var id: Int
    var title: String
    var description: String
    var link: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, link
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.link = try values.decodeIfPresent(String.self, forKey: .link) ?? ""

    }
}

