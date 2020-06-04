//
//  SayTheirNamesUITests.swift
//  SayTheirNamesUITests
//
//  Created by Hakeem King on 6/1/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import XCTest

class SayTheirNamesUITests: XCTestCase {
    var app: XCUIApplication!
    
    // MARK: - XCTestCase
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Tests
    func testHomeScreenLoading() {
        // Make sure we're displaying the collection views
        XCTAssertTrue(app.isDisplayingPeopleCollection)
        XCTAssertTrue(app.isDisplayingLocationCollection)
        
        // Make sure we are displaying all tab bar items
        XCTAssertTrue(app.isDisplayingTabBarItems)
    }
    
    func testTappingLocations() {
        let locationCount = app.locationCount

        if locationCount == 0 {
            XCTFail("Location count should not be 0")
        }
        for index in 0..<locationCount {
            XCTAssertTrue(app.locationCellForIndex(index: index).isHittable)
            app.locationCellForIndex(index: index).tap()
        }
    }
    
    func testTappingOnPerson() {
        app.firstPerson.tap()
        XCTAssertTrue(app.isDisplayingPersonDetails)
    }
}
