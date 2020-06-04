//
//  DateFormatterServiceTests.swift
//  Say Their NamesTests
//
//  Created by Hakeem King on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import XCTest
@testable import Say_Their_Names

class DateFormatterServiceTests: XCTestCase {
    
    let dateFormatterService = DateFormatterService()
    
    func testDateOfBirthFormat() {
        let dob = Date.dateFrom(year: 2020, month: 06, day: 03)!

        let formattedDate = dateFormatterService.formatYearMonthDayDate(dob)

        XCTAssertEqual(formattedDate, "Date: 2020/06/03")
    }
    
    func testHourMinuteFormat() {
        let hourMin = Date.dateFrom(year: 2020, month: 06, day: 03, hour: 4, minute: 11)!

        let formattedDate = dateFormatterService.formatHourMinuteDate(hourMin)

        XCTAssertEqual(formattedDate, "04:11")
    }
}

extension Date {
    static func dateFrom(year: Int, month: Int,  day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        components.timeZone = Calendar.current.timeZone

        return Calendar.current.date(from: components)
    }
}
