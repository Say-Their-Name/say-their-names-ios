//
//  STNDateFormatter.swift
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
import Foundation

protocol DateFormatterType {
    var timeStyle: DateFormatter.Style { get set }
    
    func string(from date: Date) -> String
    func date(from string: String) -> Date?
}

extension DateFormatter: DateFormatterType { }

final class DateFormatterService: Dependency {
    
    /// To keep thread safe, designate this queue for searching cached formatters.
    let dateFormattersQueue = DispatchQueue(label: "com.stn.date.formatter.queue")

    private var dateFormatters = [String: DateFormatterType]()

    private func cachedDateFormatter(withFormat format: String) -> DateFormatterType {
        return dateFormattersQueue.sync {
            let key = format
            if let cachedFormatter = dateFormatters[key] {
                return cachedFormatter
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = format
            
            dateFormatters[key] = dateFormatter
            
            return dateFormatter
        }
    }

    // MARK: - Year month day

    func formatYearMonthDayDate(_ date: Date) -> String {
        let dateFormatter = cachedDateFormatter(withFormat: "y/MM/dd")
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func dateForYearMonthDayString(_ dateString: String) -> Date? {
        let dateFormatter = cachedDateFormatter(withFormat: "y/MM/dd")
        return dateFormatter.date(from: dateString)
    }
    
    // MARK: - Hour minute
    
    func formatHourMinuteDate(_ date: Date) -> String {
        let dateFormatter = cachedDateFormatter(withFormat: "HH:mm")
        return dateFormatter.string(from: date)
    }

    // MARK: - Year month day Hours minutes seconds
    
    func formatYearMonthDayAndTime(_ date: Date) -> String {
        let dateFormatter = cachedDateFormatter(withFormat: "yyyy-MM-dd HH:mm:ss.SSS ")
        return dateFormatter.string(from: date)
    }
}
