//
//  LaunchScreenTests.swift
//  Say Their NamesTests
//
//  Created by christopher downey on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

@testable import Say_Their_Names
import XCTest

class LaunchScreenTests: XCTestCase {

    func testLaunchScreenCanLoadNib() {
        let screen = LaunchScreen.createFromNib()
        XCTAssertNotNil(screen)
    }
}

