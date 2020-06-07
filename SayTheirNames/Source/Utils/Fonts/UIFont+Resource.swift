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
    
    // dynamically sized
    // at the time that they're called,
    // they'll return the approrpiate font
    // for the textstyle in the given trait collection
    enum STN {
        // 28
        static var title: UIFont { UIFont.dynamicCustomFont(
        fontName: FontName.karlaBold.rawValue,
        textStyle: .title1) }
        
        // 18 on figma but this yields 17 on default
        static var body: UIFont { UIFont.dynamicCustomFont(
        fontName: FontName.karlaRegular.rawValue,
        textStyle: .body) }
        
        // 17
        static var sectionHeader: UIFont { UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .body) }
        
        // 15
        static var locationText: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .subheadline) }

        // 17
        static var filledButtonTitle: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaRegular.rawValue,
            textStyle: .body) }
        
        // 21 on figma but this yields 20 on default
        static var plainButtonTitle: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaRegular.rawValue,
            textStyle: .title3) }

        // 15
        static var cardTitle: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .subheadline) }
        
        // 14 on figma but this yields 13 on default
        static var cardSubitle: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaRegular.rawValue,
            textStyle: .footnote) }
        
        // 19 on figma but this yields 20 on default
        static var bannerTitle: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .title3) }
        
        // 17
        static var bannerSubitle: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaRegular.rawValue,
            textStyle: .body) }

        // 21 on figma but this yields 22 on default
        static var navBarTitle: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaRegular.rawValue,
            textStyle: .title2) }
        
        // 13
        static var tabButtonTitle: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .footnote) }
        
        static var verifiedTag: UIFont { UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .footnote) }

        static var summary: UIFont { UIFont.dynamicCustomFont(fontName: FontName.karlaRegular.rawValue, textStyle: .subheadline) }
        
        // 20 on figma but this yields 20 on default
        static var detailViewTitle: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .title3) }

        // 12 on FIgma, this yields 13 on default
        static var detailViewFieldTitle: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .footnote) }

        // 16 on Figma, 15 on default
        static var detailViewField: UIFont { UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .subheadline) }

        // 17
        static var hashtagButton: UIFont { UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .body) }

        // 17
        static var fullBleedButton: UIFont { UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .body) }
        
        /// Karla Bold - .body (17)
        static let ctaTitle: UIFont = UIFont.dynamicCustomFont(
            fontName: FontName.karlaBold.rawValue,
            textStyle: .body
        )
        
        /// Karla Regular - .subheadline (15)
        static let ctaBody: UIFont = UIFont.dynamicCustomFont(
            fontName: FontName.karlaRegular.rawValue,
            textStyle: .subheadline
        )
    }
}
