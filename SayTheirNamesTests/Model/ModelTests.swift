//
//  ModelTests.swift
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

import XCTest
@testable import Say_Their_Names

/// Unit Tests for the Model objects.
/// Validation is based on JSON data from the API endpoints, currently found
/// in an asset catalog of the Test bundle.
class ModelTests: XCTestCase {

    let decoder = JSONDecoder()
    var peopleData: Data = Data()
    var donationsData: Data = Data()
    var petitionsData: Data = Data()
    var searchData: Data = Data()
    
    override func setUpWithError() throws {
        
        let bundle = try XCTUnwrap(Bundle(identifier: "stn.Say-Their-NamesTests"))
        peopleData = try XCTUnwrap(NSDataAsset(name: "people", bundle: bundle)).data
        donationsData = try XCTUnwrap(NSDataAsset(name: "donations", bundle: bundle)).data
        petitionsData = try XCTUnwrap(NSDataAsset(name: "petitions", bundle: bundle)).data
        searchData = try XCTUnwrap(NSDataAsset(name: "search", bundle: bundle)).data
        
    }
    
    /// Decodes the response from the /people API endpoint and validates
    /// the data structure as well as basic assertions about the content
    func testDecodePeopleData() throws {
        
        let json = peopleData
        let personsResponse = try decoder.decode(PersonsResponsePage.self, from: json)
        
        XCTAssertNil(personsResponse.link.prev, "Previous link should be nil.")
        XCTAssertNotNil(personsResponse.link.next, "Next link should not be nil.")
        
        XCTAssertEqual(personsResponse.all.count, 12, "There should be exactly 12 persons.")
    }

    /// Decodes the response from the /donations API endpoint and validates
    /// the data structure as well as basic assertions about the content
    func testDecodeDonationsData() throws {
        
        let json = petitionsData
        let donationsResponse = try decoder.decode(DonationsResponsePage.self, from: json)
        
        XCTAssertNil(donationsResponse.link.prev, "Previous link should be nil.")
        XCTAssertNotNil(donationsResponse.link.next, "Next link should not be nil.")
        
        XCTAssertEqual(donationsResponse.all.count, 12, "There should be exactly 12 donations.")
    }

    /// Decodes the response from the /petitions API endpoint and validates
    /// the data structure as well as basic assertions about the content
    func testDecodePetitionsData() throws {
        
        let json = petitionsData
        let petitionsResponse = try decoder.decode(PetitionsResponsePage.self, from: json)
        
        XCTAssertNil(petitionsResponse.link.prev, "Previous link should be nil.")
        XCTAssertNotNil(petitionsResponse.link.next, "Next link should not be nil.")
        
        XCTAssertEqual(petitionsResponse.all.count, 12, "There should be exactly 12 petitions.")
    }
    
    /// Decodes the response from the /search API endpoint and validates
    /// the data structure as well as basic assertions about the content
    func testDecodeSearchData() throws {
        
        let json = searchData
        let searchResponse = try decoder.decode(SearchResponsePage.self, from: json)
        
        XCTAssertNil(searchResponse.link.prev, "Previous link should be nil.")
        XCTAssertNotNil(searchResponse.link.next, "Next link should not be nil.")
        
        XCTAssertEqual(searchResponse.people.count, 2, "There should be exactly 2 persons.")
        XCTAssertEqual(searchResponse.donations.count, 2, "There should be exactly 2 donations.")
        
    }

}
