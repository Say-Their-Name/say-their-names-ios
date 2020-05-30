//
//  FontResource.swift
//  Say Their Names
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
    static let stn: STN = .init()
}

extension UIFont {
    
    final class STN {
        let titleFont: UIFont = UIFont.dynamicCustomFont(fontName: FontName.karlaBold.rawValue, textStyle: TextStyle.headline)
    }
}

