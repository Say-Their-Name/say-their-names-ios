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
    
    private static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        return .init { trait in
            return trait.isDarkModeOn ? dark : light
        }
    }
    
    /// A collection of common colors
    enum STN {

        static let black: UIColor = UIColor(named: "black") ?? .black
        static let white: UIColor = UIColor(named: "white") ?? .white
        static let gray: UIColor = UIColor(named: "grey") ?? .gray
        static let darkGray = UIColor.darkGray
        static let yellow = UIColor.yellow
        static let red = UIColor.red
        
		// MARK: - Applications
        
        // MARK: - TabBar
        static let tabBarTint = UIColor.dynamic(light: .black, dark: .white)
        
        static let tabBarBarTint = UIColor.dynamic(light: .white, dark: .black)
        
        static let tabBarUnselectedItemTint = UIColor.dynamic(
            light: UIColor(hexString: "#616377").withAlphaComponent(0.568),
            dark: UIColor(hexString: "#FFFFFF").withAlphaComponent(0.568)
        )
        static let tabBarBorder = UIColor.dynamic(
            light: UIColor(hexString: "#F0F0F0"),
            dark: UIColor(hexString: "#0A0A0A")
        )
        
        // MARK: - Labels
        static let primaryLabel: UIColor = UIColor(named: "primaryLabel") ?? .label
        static let secondaryLabel: UIColor = UIColor(named: "secondaryLabel") ?? .secondaryLabel
        static let strongHeader = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1)
        static let detailLabel = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1)
        static let lightHeader = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 0.5)
        
        static let separator = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 0.4)
        /// Light (STN.black) - Dark (STN.white)
        static let actionButton: UIColor = dynamic(
            light: Self.black,
            dark: Self.white
        )
        static let background = UIColor.dynamic(light: .white, dark: .black)

    }

}
fileprivate extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
}
