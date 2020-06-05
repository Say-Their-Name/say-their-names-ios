//
//  FontResource.swift
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

private enum FontName: String {
    case karlaRegular = "Karla-Regular"
    case karlaBold = "Karla-Bold"
}

extension UIFont {
    
    /// A collection of common fonts
    enum STN {
        // 28
        static let title = UIFont.dynamicCustomFont(
        fontName: FontName.karlaBold.rawValue,
        textStyle: .title1)
        
        // 18 on figma but this yields 17 on default
        static let body = UIFont.dynamicCustomFont(
        fontName: FontName.karlaRegular.rawValue,
        textStyle: .body)
        
        // 17
        static let sectionHeader = UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .body)
        
        // 15
        static let locationText: UIFont = UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .subheadline)

        // 17
        static let filledButtonTitle: UIFont = UIFont.dynamicCustomFont(
            fontName: FontName.karlaRegular.rawValue,
            textStyle: .body)
        
        // 21 on figma but this yields 20 on default
        static let plainButtonTitle = UIFont.dynamicCustomFont(
            fontName: FontName.karlaRegular.rawValue,
            textStyle: .title3)

        // 15
        static let cardTitle = UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .subheadline)
        
        // 14 on figma but this yields 13 on default
        static let cardSubitle = UIFont.dynamicCustomFont(
            fontName: FontName.karlaRegular.rawValue,
            textStyle: .footnote)
        
        // 19 on figma but this yields 20 on default
        static let bannerTitle = UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .title3)
        
        // 17
        static let bannerSubitle = UIFont.dynamicCustomFont(
            fontName: FontName.karlaRegular.rawValue,
            textStyle: .body)

        // 21 on figma but this yields 22 on default
        static let navBarTitle = UIFont.dynamicCustomFont(
            fontName: FontName.karlaRegular.rawValue,
            textStyle: .title2)
        
        // 13
        static let tabButtonTitle = UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .footnote)
        
        static let verifiedTag: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .footnote)

        static let summary: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaRegular.rawValue, textStyle: .subheadline)
    }
}
