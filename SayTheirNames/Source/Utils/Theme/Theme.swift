//
//  Theme.swift
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

/// A collection of common constants for margins and sizes
enum Theme {
    // MARK: - Components
    enum Components {
        // MARK: - Padding
        enum Padding {
            //For cohesive design Most padding used are multiple of 8
            static let tiny: CGFloat = 4
            static let small: CGFloat = 8
            static let medium: CGFloat = 16
            static let large: CGFloat = 32
        }
        // MARK: - Button
        enum Button {
            enum Size {
                static let medium: CGSize = .init(width: 40, height: 40)
            }
        }
    }
    
    // MARK: - Screens
    enum Screens {
        // MARK: - Home
        enum Home {
            enum Columns {
                static let portrait: CGFloat = 2
                static let landscape: CGFloat = 4
            }
            enum CellSize {
                static let location: CGSize = CGSize(width: 103, height: 36)
                static let peopleHeight: CGFloat = 300
            }
            enum HeaderSize {
                static let location: CGSize = .zero
                static let peopleHeight: CGFloat = 170
            }
            enum NavigationBar {
                static let size: CGSize = .init(width: 0, height: 70)
            }
            enum LocationView {
                static let size: CGSize = .init(width: 0, height: 70)
            }
            enum SeparatorView {
                static let size: CGSize = .init(width: 0, height: 1)
            }
            enum Person {
                static let cellSpacing: CGFloat = 15
            }
        }
        
    }
}
