//
//  LocationCollectionViewDataSourceTests.swift
//  SayTheirNamesTests
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

class LocationCollectionViewDataSourceTest: XCTestCase {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    func testInitialState() throws {
        let sut = LocationCollectionViewDataSourceHelper(collectionView: collectionView)
        
         XCTAssertEqual(sut.dataSource.snapshot().sectionIdentifiers,
                        [],
                        "No sections should be there if no locations present")
         XCTAssertEqual(sut.dataSource.snapshot().itemIdentifiers(inSection: .main),
                        [],
                        "No items should be in the data source")
    }
    
    func testSetLocations() throws {
        let locations: [Location] = [Location(name: "test1"), Location(name: "test2")]
        let sut = LocationCollectionViewDataSourceHelper(collectionView: collectionView)
        
        sut.setLocations(locations)
        
        XCTAssertEqual(sut.dataSource.snapshot().sectionIdentifiers,
                       [LocationCollectionViewDataSourceHelper.Section.main],
                       "There should be one section")
        XCTAssertEqual(sut.dataSource.snapshot().itemIdentifiers(inSection: .main),
                       locations,
                       "Both items should be in the data source")
        
        let locations3: [Location] = [Location(name: "test_1"), Location(name: "test_2"), Location(name: "test_3")]
        sut.setLocations(locations3)
        
        XCTAssertEqual(sut.dataSource.snapshot().sectionIdentifiers,
                       [LocationCollectionViewDataSourceHelper.Section.main],
                       "There should be one section")
        XCTAssertEqual(sut.dataSource.snapshot().itemIdentifiers(inSection: .main),
                       locations3,
                       "New items should be in the data source after locations are set to a new array")

        sut.setLocations([])

        XCTAssertEqual(sut.dataSource.snapshot().sectionIdentifiers,
                        [],
                        "No sections should be there if no locations present")
         XCTAssertEqual(sut.dataSource.snapshot().itemIdentifiers(inSection: .main),
                        [],
                        "No items should be in the data source after locations are set to []")
    }
}
