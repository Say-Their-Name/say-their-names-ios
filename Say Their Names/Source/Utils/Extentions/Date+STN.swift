//
//  Date+STN.swift
//  Say Their Names
//
//  Created by Isuru Nanayakkara on 6/5/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

extension Date {
    func localizedString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style = .none) -> String {
        return DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }
}
