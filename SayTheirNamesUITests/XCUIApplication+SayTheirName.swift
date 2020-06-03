//
//  XCUIApplication+Home.swift
//  Say Their NamesTests
//
//  Created by Hakeem King on 6/1/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import XCTest

extension XCUIApplication {
    
    func locationCellForIndex(index: Int) -> XCUIElement {
        collectionViews.element(matching: .collectionView, identifier: "locationCollection").cells.element(matching: .cell, identifier: "locationCell\(index)")
    }
    
    var isDisplayingLocationCollection: Bool {
        return collectionViews.element(matching: .collectionView, identifier: "locationCollection").exists
    }
    
    var locationCount: Int {
        return collectionViews.element(matching: .collectionView, identifier: "locationCollection").cells.count
    }
    
    var firstPerson: XCUIElement {
        return collectionViews.element(matching: .collectionView, identifier: "peopleCollection").cells.element(matching: .cell, identifier: "peopleCell0")
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
