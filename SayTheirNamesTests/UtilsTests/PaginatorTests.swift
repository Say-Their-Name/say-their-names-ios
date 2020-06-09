//
//  PaginatorTests.swift
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

class PaginatorTests: XCTestCase {

    private enum TestData {
        static let firstPage = DummyPage(all: [5, 6, 7], link: Link(first: "firstPage_first",
                                                                    last: "firstPage_last",
                                                                    prev: "firstPage_prev",
                                                                    next: "firstPage_next"))
        static let secondPage = DummyPage(all: [10, 20, 30, 40], link: Link(first: "secondPage_first",
                                                                            last: "secondPage_last",
                                                                            prev: "secondPage_prev",
                                                                            next: "secondPage_next"))
        static let lastPage = DummyPage(all: [8, 9], link: Link(first: "thirdPage_first",
                                                                 last: "thirdPage_last",
                                                                 prev: "thirdPage_prev",
                                                                 next: nil))

        static let emptyPage = DummyPage(all: [], link: Link(first: "", last: "", prev: nil, next: nil))
    }
    
    private struct DummyPage: PaginatorResponsePage {
        var all: [Int]
        var link: Link
    }
    
    func testInit() {
        let sut = Paginator<Int, DummyPage> { (_, _) in
            XCTFail("Loader souldn't be called on init")
        }
        XCTAssertEqual(sut.state, .notLoading)
    }
    
    func testBasicLoad() {
        let expectation = self.expectation(description: "Wait for async loading operation")

        let sut = Paginator<Int, DummyPage> { (link, completion) in
            XCTAssertNil(link)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                completion(.success(TestData.firstPage))
                expectation.fulfill()
            }
        }
        
        sut.firstPageDataLoadedHandler = { (data) in
            XCTAssertEqual(data, [5, 6, 7])
        }
        sut.subsequentPageDataLoadedHandler = { (data) in
            XCTFail("Shouldn't be called")
        }
        XCTAssertEqual(sut.state, .notLoading)
        
        sut.loadNextPage()
        XCTAssertEqual(sut.state, .loading)
        self.waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.state, .notLoading)
    }
    
    func testLoadFailing() {
        enum Error: Swift.Error {
            case some
        }
        
        var resultToReturn: Result<DummyPage, Swift.Error> = .failure(Error.some)
        var expectedLink: Link?
        
        var asyncExpectation: XCTestExpectation = self.expectation(description: "Wait for async loading operation")
        
        let sut = Paginator<Int, DummyPage> { (link, completion) in
            XCTAssertEqual(link, expectedLink)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                completion(resultToReturn)
                asyncExpectation.fulfill()
            }
        }

        sut.firstPageDataLoadedHandler = { (data) in
            XCTFail("Shouldn't be called when first page fails to load")
        }
        sut.subsequentPageDataLoadedHandler = { (data) in
            XCTFail("Shouldn't be called when first page is loaded")
        }
        XCTAssertEqual(sut.state, .notLoading)
        
        sut.loadNextPage()
        XCTAssertEqual(sut.state, .loading)
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.state, .notLoading)
        
        // Load again
        
        sut.firstPageDataLoadedHandler = { (data) in
            XCTAssertEqual(data, [5, 6, 7])
        }
        sut.subsequentPageDataLoadedHandler = { (data) in
            XCTFail("Shouldn't be called when first page is loaded")
        }
        XCTAssertEqual(sut.state, .notLoading)
        
        resultToReturn = .success(TestData.firstPage)
        asyncExpectation = expectation(description: "Wait for async loading operation")
        sut.loadNextPage()
        XCTAssertEqual(sut.state, .loading)
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.state, .notLoading)
        
        // Load second page
        
        sut.firstPageDataLoadedHandler = { (data) in
            XCTFail("Shouldn't be called when subsequent page is loaded")
        }
        sut.subsequentPageDataLoadedHandler = { (data) in
            XCTAssertEqual(data, [10, 20, 30, 40])
        }
        
        resultToReturn = .success(TestData.secondPage)
        expectedLink = TestData.firstPage.link
        asyncExpectation = expectation(description: "Wait for async loading operation")
        sut.loadNextPage()
        XCTAssertEqual(sut.state, .loading)
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.state, .notLoading)
        
        // Failing third page
        
        sut.firstPageDataLoadedHandler = { (data) in
            XCTFail("Shouldn't be called when subsequent page is loaded")
        }
        sut.subsequentPageDataLoadedHandler = { (data) in
            XCTFail("Shouldn't be called when subsequent page fails to load")
        }
        
        resultToReturn = .failure(Error.some)
        expectedLink = TestData.secondPage.link
        asyncExpectation = expectation(description: "Wait for async loading operation")
        sut.loadNextPage()
        XCTAssertEqual(sut.state, .loading)
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.state, .notLoading)
        
        // Load third page
        
        sut.firstPageDataLoadedHandler = { (data) in
            XCTFail("Shouldn't be called when subsequent page is loaded")
        }
        sut.subsequentPageDataLoadedHandler = { (data) in
            XCTAssertEqual(data, [8, 9])
        }
        
        resultToReturn = .success(TestData.lastPage)
        expectedLink = TestData.secondPage.link
        asyncExpectation = expectation(description: "Wait for async loading operation")
        sut.loadNextPage()
        XCTAssertEqual(sut.state, .loading)
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.state, .notLoading)
        
        // Load empty page
        
        sut.firstPageDataLoadedHandler = { (data) in
            XCTFail("Shouldn't be called when subsequent page is loaded")
        }
        sut.subsequentPageDataLoadedHandler = { (data) in
            XCTFail("Shouldn't be called when failure comes on last page")
        }
        
        resultToReturn = .failure(Error.some)
        expectedLink = TestData.lastPage.link
        asyncExpectation = expectation(description: "Wait for async loading operation")
        sut.loadNextPage()
        XCTAssertEqual(sut.state, .loading)
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.state, .notLoading)
    }
}
