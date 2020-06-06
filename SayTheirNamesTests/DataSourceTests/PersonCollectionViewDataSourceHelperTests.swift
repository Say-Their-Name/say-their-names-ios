//
//  PersonCollectionViewDataSourceHelperTests.swift
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
import UIKit
@testable import Say_Their_Names

class PersonCollectionViewDataSourceHelperTests: XCTestCase {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    var sut: PersonCollectionViewDataSourceHelper!
    
    override func setUp() {
        super.setUp()
        sut = PersonCollectionViewDataSourceHelper(collectionView: collectionView)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testInitialState() {
        let identifiers = sut.dataSource.snapshot().sectionIdentifiers
        XCTAssertTrue(identifiers.isEmpty,
                      "Section identifiers should be empty on initialization")
    }
    
    func testSetPeople() {
        sut.setPeople([])
        let sectionIdentifiers = sut.dataSource.snapshot().sectionIdentifiers
        
        XCTAssertTrue(sectionIdentifiers.count == 1 &&
            sectionIdentifiers.first == .main,
                      "Found more sections than expected")
    }
    
    func testAppendPeople() {
        sut.setPeople([])
        let initialPeopleCount = sut.dataSource.snapshot().numberOfItems
        let newPeople = createPeople()
        sut.appendPeople(newPeople)
        
        let currentIndexCount = sut.dataSource.snapshot().numberOfItems
        
        XCTAssertEqual(currentIndexCount, newPeople.count + initialPeopleCount,
                       "Number of items does not match initial items + appended items")
    }
    
    func testPersonAtIndex() {
        let people = createPeople()
        let index = 1
        
        sut.setPeople(people)
        
        let person = sut.person(at: index)
        XCTAssertEqual(person, people[index],
                       "Item returned does not match item at same index in array")
    }
    
    func createPeople() -> [Person] {
        return (0..<5).map { index in
            Person(id: index,
                   fullName: "",
                   dob: "",
                   doi: "",
                   childrenCount: "",
                   age: "",
                   city: "",
                   country: "",
                   bio: "",
                   context: "",
                   images: [],
                   donations: DonationsResponsePage(),
                   petitions: PetitionsResponsePage(),
                   media: [],
                   socialMedia: [])
        }
    }
    
}
