//
//  XCUIApplication+Home.swift
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

extension XCUIApplication {
    
    func locationCellForIndex(index: Int) -> XCUIElement {
        collectionViews.element(
            matching: .collectionView,
            identifier: "locationCollection").cells.element(
                matching: .cell,
                identifier: "locationCell\(index)")
    }
    
    var isDisplayingLocationCollection: Bool {
        return collectionViews.element(matching: .collectionView, identifier: "locationCollection").exists
    }
    
    var locationCount: Int {
        return collectionViews.element(matching: .collectionView, identifier: "locationCollection").cells.count
    }
    
    var firstPerson: XCUIElement {
        return collectionViews.element(
            matching: .collectionView,
            identifier: "peopleCollection").cells.element(
                matching: .cell,
                identifier: "personCell0")
    }
    
    var isDisplayingPersonDetails: Bool {
        return otherElements["personView"].exists
    }
    
    var isDisplayingPeopleCollection: Bool {
        return collectionViews.element(matching: .collectionView, identifier: "peopleCollection").exists
    }
    
    var isDisplayingTabBarItems: Bool {
        return tabBars.buttons["Home"].exists
            && tabBars.buttons["Petitions"].exists
            && tabBars.buttons["Donations"].exists
    }
}
