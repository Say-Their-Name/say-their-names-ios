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

class ModelTests: XCTestCase {

    let decoder = JSONDecoder()
    var peopleData: Data = Data()
    var donationsData: Data = Data()
    var petitionsData: Data = Data()
    var searchData: Data = Data()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let bundle = try XCTUnwrap(Bundle(identifier: "stn.Say-Their-NamesTests"))
        peopleData = try XCTUnwrap(NSDataAsset(name: "people", bundle: bundle)).data
        donationsData = try XCTUnwrap(NSDataAsset(name: "donations", bundle: bundle)).data
        petitionsData = try XCTUnwrap(NSDataAsset(name: "petitions", bundle: bundle)).data
        searchData = try XCTUnwrap(NSDataAsset(name: "search", bundle: bundle)).data
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-d")
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDecodePeopleData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let json = peopleData
        let personsResponse = try decoder.decode(PersonsResponsePage.self, from: json)
        
        XCTAssertNil(personsResponse.link.prev, "Previous link should be nil.")
        XCTAssertNotNil(personsResponse.link.next, "Next link should not be nil.")
        
        XCTAssertEqual(personsResponse.all.count, 12, "There should be exactly 12 persons.")
    }

    func testDecodeDonationsData() throws {
        
        let json = petitionsData
        let donationsResponse = try decoder.decode(DonationsResponsePage.self, from: json)
        
        XCTAssertNil(donationsResponse.link.prev, "Previous link should be nil.")
        XCTAssertNotNil(donationsResponse.link.next, "Next link should not be nil.")
        
        XCTAssertEqual(donationsResponse.all.count, 12, "There should be exactly 12 donations.")
    }

    func testDecodePetitionsData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let json = petitionsData
        let petitionsResponse = try decoder.decode(PetitionsResponsePage.self, from: json)
        
        XCTAssertNil(petitionsResponse.link.prev, "Previous link should be nil.")
        XCTAssertNotNil(petitionsResponse.link.next, "Next link should not be nil.")
        
        XCTAssertEqual(petitionsResponse.all.count, 12, "There should be exactly 12 petitions.")
    }
    
    func testDecodeSearchData() throws {
        
        let json = searchData
        let searchResponse = try decoder.decode(SearchResponsePage.self, from: json)
        
        XCTAssertNil(searchResponse.link.prev, "Previous link should be nil.")
        XCTAssertNotNil(searchResponse.link.next, "Next link should not be nil.")
        
        XCTAssertEqual(searchResponse.people.count, 2, "There should be exactly 2 persons.")
        XCTAssertEqual(searchResponse.donations.count, 2, "There should be exactly 2 donations.")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
