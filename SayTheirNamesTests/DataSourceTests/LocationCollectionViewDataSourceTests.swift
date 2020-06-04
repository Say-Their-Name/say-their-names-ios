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

    func testEmptyArrayItemsInSection0Count() throws {
        let dataSource = LocationCollectionViewDataSource(locations: [])

        let numberOfSections = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfSections, 0)
    }

    func testArrayWithOneItemInSection0Count() throws {
        let locations: [Location] = [Location(name: "test")]
        let dataSource = LocationCollectionViewDataSource(locations: locations)

        let numberOfSections = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfSections, 1)
    }

    func testArrayWithOneItemInSection1CountIs0() throws {
        let locations: [Location] = [Location(name: "test")]
        let dataSource = LocationCollectionViewDataSource(locations: locations)

        let numberOfSections = dataSource.collectionView(collectionView, numberOfItemsInSection: 1)
        XCTAssertEqual(numberOfSections, 0)
    }

    func testEmptyArrayInSection1CountIs0() throws {
        let locations: [Location] = []
        let dataSource = LocationCollectionViewDataSource(locations: locations)

        let numberOfSections = dataSource.collectionView(collectionView, numberOfItemsInSection: 1)
        XCTAssertEqual(numberOfSections, 0)
    }

}
