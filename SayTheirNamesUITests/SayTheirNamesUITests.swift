//
//  SayTheirNamesUITests.swift
//  SayTheirNamesUITests
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
        XCTAssertFalse(app.isDisplayingLocationCollection, "Filters on home are disabled for v1")
        
        // Make sure we are displaying all tab bar items
        XCTAssertTrue(app.isDisplayingTabBarItems)
    }
    
    func testTappingLocations() {
        let locationCount = app.locationCount
        
        if locationCount != 0 {
            XCTFail("Filters on home are disabled for v1")
        }
        else {
            for index in 0..<locationCount {
                XCTAssertTrue(app.locationCellForIndex(index: index).isHittable)
                app.locationCellForIndex(index: index).tap()
            }
        }
    }
    
    func testTappingOnPerson() {
        app.firstPerson.tap()
        XCTAssertTrue(app.isDisplayingPersonDetails)
    }
}
