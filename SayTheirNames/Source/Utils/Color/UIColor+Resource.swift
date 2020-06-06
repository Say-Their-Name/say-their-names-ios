//
//  ColorResource.swift
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

extension UIColor {
    
    /// A collection of common colors
    enum STN {

        static let black: UIColor = UIColor(named: "black") ?? .black
        static let white: UIColor = UIColor(named: "white") ?? .white
        static let gray: UIColor = UIColor(named: "grey") ?? .gray
        static let darkGray: UIColor = UIColor(named: "darkGray") ?? .darkGray
        static let containerOutlineColor = UIColor(named: "systemGray5") ?? .systemGray5
        static let separatorColor = UIColor.systemGray6
        
		// MARK: - Applications
        
        static let tint: UIColor = UIColor(named: "tint") ?? .black
        static let unselectedTint = UIColor(red: 0.3803921569, green: 0.3882352941, blue: 0.4666666667, alpha: 0.5681668134)
        static let tabBar = UIColor(red: 0.9451505829, green: 0.9451505829, blue: 0.9451505829, alpha: 1)
        static let background = UIColor.systemBackground

		// MARK: - Labels

        static let primaryLabel: UIColor = UIColor(named: "primaryLabel") ?? .label

        static let secondaryLabel: UIColor = UIColor(named: "secondaryLabel") ?? .secondaryLabel
    }

}
