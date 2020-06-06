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

import Foundation

public struct Donation: Decodable {
    let id: Int
    let title: String
    let description: String
    let link: String
    let person: Person
    let type: DonationType
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, link, person, type
    }
}

struct DonationType: Codable {
    let id: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, type
    }
}

public struct DonationsResponsePage: Decodable {
    var all: [Donation]
    var link: Link
    
    enum CodingKeys: String, CodingKey {
        case all = "data", link = "links"
    }
    
    // Empty init
    init() {
        self.all = []
        self.link = Link(first: "", last: "", prev: "", next: "")
    }
}
