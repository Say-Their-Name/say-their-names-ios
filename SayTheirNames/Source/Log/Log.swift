//
//  Log.swift
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

import UIKit

// MARK: - Log namespace
public enum Log {
    
    public static var mode: Mode = .none
    
    public struct Mode: OptionSet {
        public let rawValue: UInt
        public init(rawValue: UInt)  { self.rawValue = rawValue }
        
        public static let none          = Mode([])
        public static let fileName      = Mode(rawValue: 1 << 0)
        public static let functionName  = Mode(rawValue: 1 << 1)
        public static let line          = Mode(rawValue: 1 << 2)
        public static let date          = Mode(rawValue: 1 << 3)
        public static let all: Mode     = [.fileName, .functionName, .line, .date]
    }
    
    public static func print(
        _ items: Any...,
        separator: String = " ",
        terminator: String = "\n",
        _ file: String = #file,
        _ function: String = #function,
        _ line: Int = #line) {
        #if DEBUG
        let prefix = self._modePrefix(file: file, function: function, line: line)
        let stringItem = items.map {"\($0)"}.joined(separator: separator)
        Swift.print("\(prefix)\(stringItem)", terminator: terminator)
        #endif
    }

    private static let dateFormatterService = DateFormatterService()

    private static func _modePrefix(file: String, function: String, line: Int) -> String {
        
        var result: String = ""
        
        if self.mode.contains(.date) {
            result += dateFormatterService.humanReadableTimestampString(from: Date())
            result += " "
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
