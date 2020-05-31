//
//  Log.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

import UIKit

// MARK: - Log
public struct Log {
    public static var mode: Mode = .none

    public struct Mode : OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt)  { self.rawValue = rawValue }
        
        public static let none          = Mode([])
        public static let fileName      = Mode(rawValue: 1 << 0)
        public static let functionName  = Mode(rawValue: 1 << 1)
        public static let line          = Mode(rawValue: 1 << 2)
        public static let date          = Mode(rawValue: 1 << 3)
        public static let all: Mode     = [.fileName, .functionName, .line, .date]
    }
    
    public static func print(_ items: Any..., separator: String = " ", terminator: String = "\n", _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        #if DEBUG
            let prefix = self._modePrefix(file: file, function: function, line: line)
            let stringItem = items.map {"\($0)"}.joined(separator: separator)
            Swift.print("\(prefix)\(stringItem)", terminator: terminator)
        #endif
    }
    
    private static func _modePrefix(file: String, function: String, line: Int) -> String {
        var result: String = ""
        
        if self.mode.contains(.date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
            
            let s = formatter.string(from: Date())
            result += s
        }
        
        if self.mode.contains(.fileName) {
            let filename = file.lastPathComponent.stringByDeletingPathExtension
            result += "\(filename)."
        }
        
        if self.mode.contains(.functionName) {
            result += "\(function)"
        }
        
        if self.mode.contains(.line) {
            result += "[\(line)]"
        }
        
        if result.isNotEmpty {
            result = result.trimmingCharacters(in: .whitespaces)
            result += ": "
        }
        
        return result
    }
}

// MARK: - Loggable
@objc protocol Loggable {
    func desc() -> String
}

