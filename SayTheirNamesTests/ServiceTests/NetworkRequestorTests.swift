//
//  NetworkRequestorTests.swift
//  SayTheirNamesTests
//
//  Created by Oliver Binns on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

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
        guard let url = URL(string: "https://example.com") else { XCTFail("URL was not valid"); return }
        let mockString = "{\"data\":\"Testing\"}".data(using: .utf8)!
        Mock(url: url, dataType: .json, statusCode: 200, data: [.get: mockString]).register()

        // Make request, and expect the error to be returned
        let requestExpectation = expectation(description: "Request should return")
        sut.fetchDecodable(url.absoluteString) { (result: Result<TestObject, AFError>) in
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

    func test_fetchDecodable_propagatesAFError() {
        guard let url = URL(string: "https://example.com") else { XCTFail("URL was not valid"); return }
        Mock(url: url, dataType: .json, statusCode: 200, data: [.get: Data()]).register()

        // Make request, and expect the error to be returned
        let requestExpectation = expectation(description: "Request should return")
        sut.fetchDecodable(url.absoluteString) { (result: Result<TestObject, AFError>) in
            switch result {
            case .failure(.responseSerializationFailed(reason: .inputDataNilOrZeroLength)):
                requestExpectation.fulfill()
            default:
                XCTFail("Expected a decoding failure")
            }
        }

        // Wait for request to be made and returned
        wait(for: [requestExpectation], timeout: 2)
    }
}
