//
//  PetitionsNetworkRequestor.swift
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

import Mocker
import XCTest
@testable import Say_Their_Names

extension NetworkRequestorTests {
    func test_fetchPetitions_makesRequest() {
        guard let apiEndpoint = URL(string: PetitionEnvironment.baseUrlSring) else {
            XCTFail("URL was not valid")
            return
        }

        // Set up mock to return data from the endpoint, and expectation that the request is made
        let makeRequestExpectation = expectation(description: "Request should made")
        var mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: Data()])
        mock.completion = {
            makeRequestExpectation.fulfill()
        }
        mock.register()

        // Make request and expect that a result is returned
        let returnRequestExpection = expectation(description: "Request should return")
        sut.fetchPetitions { _ in
            returnRequestExpection.fulfill()
        }

        // Wait for request to be made and returned
        wait(for: [makeRequestExpectation, returnRequestExpection], timeout: 2)
    }
    
    func test_fetchPetitionsPersonName_makesRequest() {
        guard let apiEndpoint = URL(string: PetitionEnvironment.petitionsSearchString) else {
            XCTFail("URL was not valid")
            return
        }

        // Set up mock to return data from the endpoint, and expectation that the request is made
        let makeRequestExpectation = expectation(description: "Request should be made")
        var mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: Data()])
        mock.completion = {
            makeRequestExpectation.fulfill()
        }
        mock.register()

        // Make request and expect that a result is returned
        let returnRequestExpection = expectation(description: "Request should return")
        sut.fetchPetitionsByPersonName("george") { _ in
            returnRequestExpection.fulfill()
        }

        // Wait for request to be made and returned
        wait(for: [makeRequestExpectation, returnRequestExpection], timeout: 15)
    }
    
    func test_fetchPetitionsByType_makesRequest() {
        guard let apiEndpoint = URL(string: PetitionEnvironment.petitionsTypeSearchString) else {
            XCTFail("URL was not valid")
            return
        }

        // Set up mock to return data from the endpoint, and expectation that the request is made
        let makeRequestExpectation = expectation(description: "Request should be made")
        var mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: Data()])
        mock.completion = {
            makeRequestExpectation.fulfill()
        }
        mock.register()

        // Make request and expect that a result is returned
        let returnRequestExpection = expectation(description: "Request should return")
        sut.fetchPetitionsByType("victim") { _ in
            returnRequestExpection.fulfill()
        }

        // Wait for request to be made and returned
        wait(for: [makeRequestExpectation, returnRequestExpection], timeout: 15)
    }
}
