//
//  UIFontSTNTests.swift
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
