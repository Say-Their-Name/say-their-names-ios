//
//  LocationCollectionViewDataSourceTests.swift
//  SayTheirNamesTests
//
//  Created by Roderic Campbell on 6/4/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

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
