//
//  UIFontSTNTests.swift
//  SayTheirNamesTests
//
//  Created by Marina Gornostaeva on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import XCTest
@testable import Say_Their_Names

class UIFontSTNTests: XCTestCase {

    func test_fixedCustomFont() {
        let sutNonExisting = UIFont.fixedCustomFont(fontName: "abc", size: 100)
        XCTAssertEqual(sutNonExisting.pointSize, 100)
        
        let sutExisting = UIFont.fixedCustomFont(fontName: "Helvetica", size: 20)
        XCTAssertEqual(sutExisting.pointSize, 20)
        XCTAssertEqual(sutExisting.familyName, "Helvetica")
    }
    
    func test_dynamicCustomFont() {
        let sutNonExisting = UIFont.dynamicCustomFont(fontName: "abc", textStyle: .largeTitle)
        XCTAssertEqual(sutNonExisting.pointSize, UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
        
        let sutExisting = UIFont.dynamicCustomFont(fontName: "Helvetica", textStyle: .caption1)
        XCTAssertEqual(sutExisting.pointSize, UIFont.preferredFont(forTextStyle: .caption1).pointSize)
        XCTAssertEqual(sutExisting.familyName, "Helvetica")
    }
}
