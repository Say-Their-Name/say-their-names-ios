//
//  NetworkRequestorTests.swift
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

import Alamofire
import Mocker
import XCTest
@testable import Say_Their_Names

final class NetworkRequestorTests: XCTestCase {

    private struct TestObject: Decodable {
        let data: String
    }

    var sut: NetworkRequestor!

    override func setUp() {
        super.setUp()

        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let session = Session(configuration: configuration)
        sut = NetworkRequestor(session: session)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_fetchDecodable_returnsObject() {
        guard let url = URL(string: Environment.serverURLString),
            let mockString = "{\"data\":\"Testing\"}".data(using: .utf8) else {
            XCTFail("Could not complete test setup.")
            return
        }
        Mock(url: url, dataType: .json, statusCode: 200, data: [.get: mockString]).register()

        // Make request, and expect the error to be returned
        let requestExpectation = expectation(description: "Request should return")
        sut.fetchDecodable(url.absoluteString) { (result: Result<TestObject, Swift.Error>) in
            switch result {
            case .success(let object):
                XCTAssertEqual(object.data, "Testing")
                requestExpectation.fulfill()
            default:
                XCTFail("Expected a decoding failure")
            }
        }

        // Wait for request to be made and returned
        wait(for: [requestExpectation], timeout: 2)
    }

    func test_fetchDecodable_propagatesSwiftError() {
        guard let url = URL(string: Environment.serverURLString) else { XCTFail("URL was not valid"); return }
        Mock(url: url, dataType: .json, statusCode: 200, data: [.get: Data()]).register()

        // Make request, and expect the error to be returned
        let requestExpectation = expectation(description: "Request should return")
        sut.fetchDecodable(url.absoluteString) { (result: Result<TestObject, Swift.Error>) in
            switch result {
            case .failure:
                requestExpectation.fulfill()
            default:
                XCTFail("Expected a decoding failure")
            }
        }

        // Wait for request to be made and returned
        wait(for: [requestExpectation], timeout: 2)
    }
}
