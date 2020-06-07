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
    
    func testSetPeopleAndCarouselEmpty() {
        sut.setPeople([], carouselData: [])
        let snapshot = sut.dataSource.snapshot()
        
        XCTAssertEqual(snapshot.sectionIdentifiers, [.carousel, .main],
                      "Found incorrect sections")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .main).count, 0, "Main section should have 0 items")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .carousel).count, 0, "Carousel section should have 0 items")
    }
    
    func testSetPeopleAndCarouselNonEmptyPeople() {
        let people = createPeople(rangeOfIndices: 1...5)
        sut.setPeople(people, carouselData: [])
        let snapshot = sut.dataSource.snapshot()
        
        XCTAssertEqual(snapshot.sectionIdentifiers, [.carousel, .main],
                      "Found incorrect sections")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .main).count, 5, "Main section should have 5 items")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .carousel).count, 0, "Carousel section should have 0 items")
    }
    
    func testSetPeopleAndCarouselNonEmptyCarousel() {
        let carouselData = createCarouselData(rangeOfIndices: 1...3)
        sut.setPeople([], carouselData: carouselData)
        let snapshot = sut.dataSource.snapshot()

        XCTAssertEqual(snapshot.sectionIdentifiers, [.carousel, .main],
                      "Found incorrect sections")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .main).count, 0, "Main section should have 0 items")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .carousel).count, 3, "Carousel section should have 3 items")
    }
    
    func testSetPeopleAndCarouselNonEmptyBoth() {
        let people = createPeople(rangeOfIndices: 1...5)
        let carouselData = createCarouselData(rangeOfIndices: 1...3)
        sut.setPeople(people, carouselData: carouselData)
        let snapshot = sut.dataSource.snapshot()

        XCTAssertEqual(snapshot.sectionIdentifiers, [.carousel, .main],
                      "Found incorrect sections")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .main).count, 5, "Main section should have 5 items")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .carousel).count, 3, "Carousel section should have 3 items")

    }
    
    func testAppendPeopleToEmpty() {
        sut.setPeople([], carouselData: [])
        let newPeople = createPeople(rangeOfIndices: 1...5)
        sut.appendPeople(newPeople)
        
        let snapshot = sut.dataSource.snapshot()

        XCTAssertEqual(snapshot.sectionIdentifiers, [.carousel, .main],
                      "Found incorrect sections")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .main).count, 5, "Main section should have 5 items")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .carousel).count, 0, "Carousel section should have 0 items")
    }
    
    func testAppendPeopleToNonEmpty() {
        let people = createPeople(rangeOfIndices: 1...5)
        let carouselData = createCarouselData(rangeOfIndices: 1...3)
        sut.setPeople(people, carouselData: carouselData)

        let newPeople = createPeople(rangeOfIndices: 11...19)
        sut.appendPeople(newPeople)

        let snapshot = sut.dataSource.snapshot()

        XCTAssertEqual(snapshot.sectionIdentifiers, [.carousel, .main],
                      "Found incorrect sections")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .main).count, 5+9, "Main section should have 5+9=14 items")
        XCTAssertEqual(snapshot.itemIdentifiers(inSection: .carousel).count, 3, "Carousel section should still have 3 items")
    }
    
    func testPersonAtIndex() {
        let people = createPeople(rangeOfIndices: 1...5)
        let carouselData = createCarouselData(rangeOfIndices: 12...15)
        sut.setPeople(people, carouselData: carouselData)
        
        let person0 = sut.person(at: 0)
        let person4 = sut.person(at: 4)

        XCTAssertEqual(person0, people[0],
                       "Item returned does not match item at same index in array")
        XCTAssertEqual(person4, people[4],
                       "Item returned does not match item at same index in array")
    }

    // MARK: - Help -
    
    private func createPeople(rangeOfIndices: ClosedRange<Int>) -> [Person] {
        return rangeOfIndices.map { index in
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
    
    private func createCarouselData(rangeOfIndices: ClosedRange<Int>) -> [HeaderCellContent] {
        return rangeOfIndices.map { _ in
            HeaderCellContent(title: "hello", description: "world")
        }
    }
}
