//
//  FontResource.swift
//  SayTheirNames
//
//  Created by evilpenguin on 5/30/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

private enum FontName: String {
    case karlaRegular = "Karla-Regular"
    case karlaBold = "Karla-Bold"
}

extension UIFont {
    
    /// A collection of common fonts
    enum STN {
        static let title: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .title1) // 28
        static let body: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaRegular.rawValue, textStyle: .body) // 18 on figma but this yields 17 on default
        static let sectionHeader: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .body) // 17
        static let locationText: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .subheadline) // 15

        static let filledButtonTitle: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaRegular.rawValue, textStyle: .body) // 17
        static let plainButtonTitle: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaRegular.rawValue, textStyle: .title3) // 21 on figma but this yields 20 on default

        static let cardTitle: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .subheadline) // 15
        static let cardSubitle: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaRegular.rawValue, textStyle: .footnote) // 14 on figma but this yields 13 on default
        
        static let bannerTitle: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .title3) // 19 on figma but this yields 20 on default
        static let bannerSubitle: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaRegular.rawValue, textStyle: .body) // 17

        static let navBarTitle: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaRegular.rawValue, textStyle: .title2) // 21 on figma but this yields 22 on default
        
        static let tabButtonTitle: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: .footnote) // 13

    }
}
