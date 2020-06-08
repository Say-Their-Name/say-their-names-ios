//
//  DateFormatterServiceTests.swift
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

import XCTest
@testable import Say_Their_Names

class DateFormatterServiceTests: XCTestCase {
    
    let dateFormatterService = DateFormatterService()
    
    func testDateOfBirthFormat() {
        guard let dob = Date.dateFrom(year: 2020, month: 06, day: 03) else {
            XCTFail("unable to create dob")
            return
        }

        let formattedDate = dateFormatterService.formatYearMonthDayDate(dob)

        XCTAssertEqual(formattedDate, "2020/06/03")
    }
    
    func testHourMinuteFormat() {
        guard let hourMin = Date.dateFrom(year: 2020, month: 06, day: 03, hour: 4, minute: 11) else {
            XCTFail("unable to create date")
            return
        }

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
