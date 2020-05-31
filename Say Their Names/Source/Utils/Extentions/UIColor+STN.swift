//
//  UIColor+STN.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/30/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - UIColor

extension UIColor {
    public class func color(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) -> UIColor {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(a >= 0 && a <= 1, "Invalid alpha component")
        
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    public class func hexColor(_ rgb: Int, alpha: CGFloat = 1.0) -> UIColor {
        return self.color(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF, a: alpha)
    }
}
