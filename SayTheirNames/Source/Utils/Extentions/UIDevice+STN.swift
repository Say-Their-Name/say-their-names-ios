//
//  UIDevice+STN.swift
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

// MARK: - STNDevice

public typealias STNDevice = UIDevice
extension STNDevice {
    // MARK: - Class Methods
    class var screenSize: STNSize {
        let bounds = UIScreen.main.nativeBounds
        switch bounds.height {
        case 960.0:
            return .small(frame: bounds)    // iPhone 4/4s
        case 1136.0:
            return .medium(frame: bounds)  // iPhone 5/5S/5C
        case 1334.0:
            return .large(frame: bounds)   // iPhone 6/6S/7/8
        case 2208.0:
            return .xlarge(frame: bounds)  // iPhone 6+/7+/8+
        case 2436.0:
            return .x(frame: bounds)       // iPhone X
        default:
            break
        }
        return .unknown()
    }
}
