//
//  Model_SearchTests.swift
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

class Model_SearchTests: XCTestCase {

    let decoder = JSONDecoder()
    
    // The search string is based on the following query parameter :
    //   search?query=floyd
    let searchString = #"""
{"data":{"results":[{"searchable":{"id":23,"full_name":"George Floyd","identifier":"george-floyd","date_of_incident":"2020-05-25","number_of_children":2,"age":46,"city":"Minnesota","country":"United States","biography":null,"context":"Officers responding to a \"forgery in progress\" detained Floyd, kneeling on his neck for several minutes. Floyd did not resist arrest and repeatedly told the officers \"please\" and \"I can't breathe\".[2] Bystanders urged the officers to let Floyd up as he went quiet and stopped moving.","outcome":null,"sharable_links":{"base":"https:\/\/www.saythiernames.io\/people\/george-floyd","facebook":"https:\/\/www.facebook.com\/sharer\/sharer.php?u=https:\/\/www.saythiernames.io\/people\/george-floyd","twitter":"https:\/\/twitter.com\/home?status=https:\/\/www.saythiernames.io\/people\/george-floyd","whatsapp":"https:\/\/wa.me\/?text=https:\/\/www.saythiernames.io\/people\/george-floyd"}},"title":"george-floyd","url":null,"type":"people"},{"searchable":{"id":37,"full_name":"Jamel Floyd","identifier":"jamel-floyd","date_of_incident":"2020-06-03","number_of_children":0,"age":35,"city":"New York - NY","country":"United States","biography":null,"context":"Jamel Floyd, an inmate at the Metropolitan Detention Center, died of a heart attack after correctional officers pepper-sprayed him in his cell.","outcome":null,"sharable_links":{"base":"https:\/\/www.saythiernames.io\/people\/jamel-floyd","facebook":"https:\/\/www.facebook.com\/sharer\/sharer.php?u=https:\/\/www.saythiernames.io\/people\/jamel-floyd","twitter":"https:\/\/twitter.com\/home?status=https:\/\/www.saythiernames.io\/people\/jamel-floyd","whatsapp":"https:\/\/wa.me\/?text=https:\/\/www.saythiernames.io\/people\/jamel-floyd"}},"title":"jamel-floyd","url":null,"type":"people"},{"searchable":{"id":3,"person_id":23,"type_id":1,"identifier":"donate-to-george-floyd","banner_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/petition.png","title":"Donate to George Floyd","description":"Donate George Floyd by donating here","outcome":null,"outcome_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/petition.png","link":"https:\/\/www.gofundme.com\/f\/georgefloyd","sharable_links":{"base":"https:\/\/www.saythiernames.io\/donations\/","facebook":"https:\/\/www.facebook.com\/sharer\/sharer.php?u=https:\/\/www.saythiernames.io\/donations\/","twitter":"https:\/\/twitter.com\/home?status=https:\/\/www.saythiernames.io\/donations\/","whatsapp":"https:\/\/wa.me\/?text=https:\/\/www.saythiernames.io\/donations\/"}},"title":"3","url":null,"type":"donation_links"},{"searchable":{"id":5,"person_id":37,"type_id":1,"identifier":"donate-to-jamel-floyd","banner_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/petition.png","title":"Donate to Jamel Floyd","description":"Donate Jamel Floyd by donating here","outcome":null,"outcome_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/petition.png","link":"https:\/\/www.gofundme.com\/f\/justice-for-jamel-floyd","sharable_links":{"base":"https:\/\/www.saythiernames.io\/donations\/","facebook":"https:\/\/www.facebook.com\/sharer\/sharer.php?u=https:\/\/www.saythiernames.io\/donations\/","twitter":"https:\/\/twitter.com\/home?status=https:\/\/www.saythiernames.io\/donations\/","whatsapp":"https:\/\/wa.me\/?text=https:\/\/www.saythiernames.io\/donations\/"}},"title":"5","url":null,"type":"donation_links"},{"searchable":{"id":1,"person_id":2,"type_id":1,"identifier":"petition-for-james-scurlock","banner_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/petition.png","title":"Petition For James Scurlock","description":"Help bring justice to James Scurlock by signing this petition","outcome":null,"outcome_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/petition.png","link":"https:\/\/www.change.org\/p\/demand-justice-for-james-scurlock-killed-by-omaha-racist-during-george-floyd-protest","sharable_links":{"base":"https:\/\/www.saythiernames.io\/petition\/","facebook":"https:\/\/www.facebook.com\/sharer\/sharer.php?u=https:\/\/www.saythiernames.io\/petition\/","twitter":"https:\/\/twitter.com\/home?status=https:\/\/www.saythiernames.io\/petition\/","whatsapp":"https:\/\/wa.me\/?text=https:\/\/www.saythiernames.io\/petition\/"}},"title":"1","url":null,"type":"petition_links"},{"searchable":{"id":10,"person_id":23,"type_id":1,"identifier":"petition-for-george-floyd","banner_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/petition.png","title":"Petition For George Floyd","description":"Help bring justice to George Floyd by signing this petition","outcome":null,"outcome_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/petition.png","link":"https:\/\/www.change.org\/p\/mayor-jacob-frey-justice-for-george-floyd","sharable_links":{"base":"https:\/\/www.saythiernames.io\/petition\/","facebook":"https:\/\/www.facebook.com\/sharer\/sharer.php?u=https:\/\/www.saythiernames.io\/petition\/","twitter":"https:\/\/twitter.com\/home?status=https:\/\/www.saythiernames.io\/petition\/","whatsapp":"https:\/\/wa.me\/?text=https:\/\/www.saythiernames.io\/petition\/"}},"title":"10","url":null,"type":"petition_links"},{"searchable":{"id":15,"person_id":37,"type_id":1,"identifier":"petition-for-jamel-floyd","banner_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/petition.png","title":"Petition For Jamel Floyd","description":"Help bring justice to Jamel Floyd by signing this petition","outcome":null,"outcome_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/petition.png","link":"https:\/\/www.change.org\/p\/justice-for-jamel-floyd","sharable_links":{"base":"https:\/\/www.saythiernames.io\/petition\/","facebook":"https:\/\/www.facebook.com\/sharer\/sharer.php?u=https:\/\/www.saythiernames.io\/petition\/","twitter":"https:\/\/twitter.com\/home?status=https:\/\/www.saythiernames.io\/petition\/","whatsapp":"https:\/\/wa.me\/?text=https:\/\/www.saythiernames.io\/petition\/"}},"title":"15","url":null,"type":"petition_links"},{"searchable":{"id":66,"person_id":null,"type_id":2,"identifier":"justiceforfloyd","banner_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/donations\/black-lives-matter-fund\/black-lives-matter.jpg","title":"#JusticeForFloyd","description":"Demand the officers who killed George Floyd are charged with murder.","outcome":null,"outcome_img_url":"https:\/\/say-their-names.fra1.cdn.digitaloceanspaces.com\/donations\/black-lives-matter-fund\/black-lives-matter-1.jpg","link":"https:\/\/act.colorofchange.org\/sign\/justiceforfloyd_george_floyd_minneapolis","sharable_links":{"base":"https:\/\/www.saythiernames.io\/petition\/","facebook":"https:\/\/www.facebook.com\/sharer\/sharer.php?u=https:\/\/www.saythiernames.io\/petition\/","twitter":"https:\/\/twitter.com\/home?status=https:\/\/www.saythiernames.io\/petition\/","whatsapp":"https:\/\/wa.me\/?text=https:\/\/www.saythiernames.io\/petition\/"}},"title":"66","url":null,"type":"petition_links"}]}}
"""#
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInit() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let json = Data(searchString.utf8)
        let searchResponse = try decoder.decode(SearchResponsePage.self, from: json)
        
        XCTAssertNil(searchResponse.link.prev, "Previous link should be nil.")
        XCTAssertNotNil(searchResponse.link.next, "Next link should not be nil.")
        
        XCTAssertEqual(searchResponse.people.count, 2, "There should be exactly 2 persons.")
        XCTAssertEqual(searchResponse.donations.count, 2, "There should be exactly 2 donations.")

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
