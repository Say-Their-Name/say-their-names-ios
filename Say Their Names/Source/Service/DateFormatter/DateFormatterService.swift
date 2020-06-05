//
//  STNDateFormatter.swift
//  Say Their Names
//
//  Created by Hakeem King on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

protocol DateFormatterType {
    func string(from date: Date) -> String
}

extension DateFormatter: DateFormatterType { }

class DateFormatterService {
    
    /// To keep thread safe, designate this queue for searching cached formatters.
    let dateFormattersQueue = DispatchQueue(label: "com.stn.date.formatter.queue")

    private var dateFormatters = [String : DateFormatterType]()

    private func cachedDateFormatter(withFormat format: String) -> DateFormatterType {
        return dateFormattersQueue.sync {
            let key = format
            if let cachedFormatter = dateFormatters[key] {
                return cachedFormatter
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            
            dateFormatters[key] = dateFormatter
            
            return dateFormatters[key]!
        }
    }

    func localizedString(date: Date, dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style = .none) -> String {
        return DateFormatter.localizedString(from: date, dateStyle: dateStyle, timeStyle: timeStyle)
    }
    
    // MARK: - Year month day

    func formatYearMonthDayDate(_ date: Date) -> String {
        let dateFormatter = cachedDateFormatter(withFormat: "y/MM/dd")
        let formattedDate = dateFormatter.string(from: date)
        return ("Date: \(formattedDate)")
    }
    
    // MARK: - Hour minute
    
    func formatHourMinuteDate(_ date: Date) -> String {
        let dateFormatter = cachedDateFormatter(withFormat: "HH:mm")
        return dateFormatter.string(from: date)
    }

}
