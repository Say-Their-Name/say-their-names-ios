//
//  DeepLinkTests.swift
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

/// Unit Tests for the Deep Linking mechanism.
/// The test cases rely on properly building a set of `DeepLink`s
/// from the DeepLinkHandler's `handle(urls:)` method.
///
class DeepLinkTests: XCTestCase {

    // The URLs that will be used to construct the deep links.
    var dlAbout: URL!
    var dlPeopleJaoP: URL!
    var dlPetitions: URL!
    var dlDonations: URL!
    var dlPetitionScurlock: URL!
    var dlDonationFloydG: URL!
    
    // The scheme and host that should be used.
    let dlScheme = "stn"
    let dlHost = "saytheirname.netlify.app"
    
    // The relative paths for deep link URLs
    let dlPathAbout = "about"
    let dlPathPeopleJaoP = "profile/joao-pedro"
    let dlPathPetitions = "petitions"
    let dlPathDonations = "donations"
    let dlPathPetitionScurlock = "petitions/petition-for-james-scurlock"
    let dlPathDonationFloydG = "donate/donate-to-george-floyd"
    
    var container: DependencyContainer!

    override func setUpWithError() throws {

        // We setup all the deep link URLs. An exception is thrown is the URL
        // can't be built from the given string.
        dlAbout = try XCTUnwrap(URL(string: dlScheme + "://" + dlHost + "/" + dlPathAbout))
        dlPeopleJaoP = try XCTUnwrap(URL(string: dlScheme + "://" + dlHost + "/" + dlPathPeopleJaoP))
        dlPetitions = try XCTUnwrap(URL(string: dlScheme + "://" + dlHost + "/" + dlPathPetitions))
        dlDonations = try XCTUnwrap(URL(string: dlScheme + "://" + dlHost + "/" + dlPathDonations))
        dlPetitionScurlock = try XCTUnwrap(URL(string: dlScheme + "://" + dlHost + "/" + dlPathPetitionScurlock))
        dlDonationFloydG = try XCTUnwrap(URL(string: dlScheme + "://" + dlHost + "/" + dlPathDonationFloydG))

        // We instantiate the dependency container that will be used to build
        // the various `DeepLink` objects, via `.deepLinkHandler.handle(urls:)`
        container = DependencyContainer()
    }

    /// Testing the About deep link.
    func testAboutDeepLink() {
        let results = container.deepLinkHandler.handle(urls: Set([dlAbout]))
        
        self.helperAssertion(deeplinks: results,
                                 controller: MoreController.self,
                                 deeplinkDescription: "The About",
                                 location: dlPathAbout)
    }
    
    /// Testing the People Detail deep link.
    /// This is a link to a specific person's profile.
    func testPeopleJaoPDeepLink() {
        let results = container.deepLinkHandler.handle(urls: Set([dlPeopleJaoP]))
        
        self.helperAssertion(deeplinks: results,
                                 controller: HomeController.self,
                                 deeplinkDescription: "The People Detail",
                                 location: dlPathPeopleJaoP)

    }
    
    /// Testing the Petitions deep link.
    func testPetitionsDeepLink() {
        let results = container.deepLinkHandler.handle(urls: Set([dlPetitions]))
        
        self.helperAssertion(deeplinks: results,
                                 controller: PetitionsController.self,
                                 deeplinkDescription: "The Petitions",
                                 location: dlPathPetitions)
    }

    /// Testing the Donations deep link.
    func testDonationsDeepLink() {
        let results = container.deepLinkHandler.handle(urls: Set([dlDonations]))
        
        self.helperAssertion(deeplinks: results,
                                 controller: DonationsController.self,
                                 deeplinkDescription: "The Donations",
                                 location: dlPathDonations)
    }
    
    /// Testing the Petitions Detail deep link.
    /// This is a link to a specific petition page.
    func testPetitionScurlockDeepLink() {
        let results = container.deepLinkHandler.handle(urls: Set([dlPetitionScurlock]))
        
        self.helperAssertion(deeplinks: results,
                             controller: PetitionsController.self,
                             deeplinkDescription: "The Petition Detail",
                             location: dlPathPetitionScurlock)
    }
    
    /// Testing the Donation Detail deep link.
    /// This is a link to a specific donation page.
    func testDonationFloydG() {
        let results = container.deepLinkHandler.handle(urls: Set([dlDonationFloydG]))
        
        self.helperAssertion(deeplinks: results,
                             controller: DonationsController.self,
                             deeplinkDescription: "The Donation Detail",
                             location: dlPathDonationFloydG)
    }

    /// Helper method that will test the following assertions based
    /// on the provided `DeepLink` array :
    ///   - there should only be one DeepLink for this test case.
    ///   - the DeepLink has the appropriate display class (view controller)
    ///   - the DeepLink has the correct scheme and host
    ///   - the DeepLink has the correct path location (first part of the path components)
    ///
    func helperAssertion(deeplinks: [DeepLink],
                         controller: UIViewController.Type,
                         deeplinkDescription: String,
                         location: String) {
        
        XCTAssertTrue(deeplinks.count == 1, "There should be only one (deep link).")
        
        for deeplink in deeplinks  {
            let details = type(of: deeplink).details
            XCTAssertTrue(details.canDisplayClass(controller.self),
                          deeplinkDescription + " DeepLink should be shown in the \(controller.description())")
            XCTAssertTrue(details.uses(scheme: dlScheme, host: dlHost),
                          "The scheme or host is incorrect")
            XCTAssertTrue(details.has(location: location.components(separatedBy: "/").first ?? location),
                          "The path component is incorrect")
        }

    }
}
