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
        let bundle = Bundle(for: LaunchScreen.self)
      guard let _ = bundle.loadNibNamed("LaunchScreen", owner: nil)?.first as? LaunchScreen else {
        return XCTFail("LaunchScreen nib failed to load as LaunchScreen")
      }
    }
    
    func testInitializingWithFrameWorks() {
      let frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    XCTAssertFalse(LaunchScreen(frame: frame).subviews.isEmpty,
        "LaunchScreen should add subviews from nib when instantiated in code")
    }
}
