//
//  PeopleNetworkRequestorTests.swift
//  SayTheirNamesTests
//
//  Created by Oliver Binns on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Mocker
import XCTest
@testable import Say_Their_Names

extension NetworkRequestorTests {
    func test_fetchPeople_makesRequest() {
        guard let apiEndpoint = URL(string: PersonEnvironment.urlString) else {
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
        sut.fetchPeople { _ in
            returnRequestExpection.fulfill()
        }

        // Wait for request to be made and returned
        wait(for: [makeRequestExpectation, returnRequestExpection], timeout: 2)
    }
}
