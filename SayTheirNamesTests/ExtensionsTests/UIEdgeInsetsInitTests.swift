//
//  UIEdgeInsetsInitTests.swift
//  SayTheirNames
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

class UIEdgeInsetsInitTests: XCTestCase {
    
    private var subject: UIEdgeInsets!
    
    override func setUp() {
        super.setUp()
        subject = UIEdgeInsets()
    }

    override func tearDown() {
        super.tearDown()
        subject = nil
    }

    func test_init_top_isEqualToZero() {
        XCTAssertEqual(subject.top, 0)
    }
    
    func test_init_bottom_isEqualToZero() {
        XCTAssertEqual(subject.bottom, 0)
    }
    
    func test_init_right_isEqualToZero() {
        XCTAssertEqual(subject.right, 0)
    }
    
    func test_init_left_isEqualToZero() {
        XCTAssertEqual(subject.left, 0)
    }
    
    func test_medium_top_isEqualToExpectedValue() {
        subject = .medium
        XCTAssertEqual(subject.top, 16)
    }
    
    func test_medium_bottom_isEqualToExpectedValue() {
        subject = .medium
        XCTAssertEqual(subject.bottom, 16)
    }
    
    func test_medium_right_isEqualToExpectedValue() {
        subject = .medium
        XCTAssertEqual(subject.right, 16)
    }
    
    func test_medium_left_isEqualToExpectedValue() {
        subject = .medium
        XCTAssertEqual(subject.left, 16)
    }
}
