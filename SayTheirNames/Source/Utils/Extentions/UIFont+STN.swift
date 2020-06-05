//
//  UIFont+STN.swift
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

extension UIFont {
    
    /// Makes a font of dynamic size corresponding to textStyle
    /// These fonts don't change size live. Easier to develop for non-dynamic interfaces (for now)
    class func dynamicCustomFont(fontName: String, textStyle: UIFont.TextStyle) -> UIFont {
        
        let uiFont: UIFont
        
        let preferredSize = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle).pointSize
        
        // If font doesn't exist, it would default to Helvetica, not SF, and it doesn't look good
        let fontDescriptor = UIFontDescriptor(name: fontName, size: preferredSize)
        if self.doesFontExist(fontDescriptor: fontDescriptor) {
            uiFont = UIFont(descriptor: fontDescriptor, size: 0)
        }
        else {
            uiFont = UIFont.preferredFont(forTextStyle: textStyle)
            print("Got invalid font \(fontName) with style \(textStyle). Using \(uiFont)")
        }
        
        return uiFont
    }
    
    /// Makes a font of fixed size
    class func fixedCustomFont(fontName: String, size: CGFloat) -> UIFont {
        
        let uiFont: UIFont
        
        let fontDescriptor = UIFontDescriptor(name: fontName, size: size)
        // If font doesn't exist, it would default to Helvetica, not SF, and it doesn't look good
        if self.doesFontExist(fontDescriptor: fontDescriptor) {
            uiFont = UIFont(descriptor: fontDescriptor, size: 0)
        }
        else {
            uiFont = UIFont.systemFont(ofSize: size)
            print("Got invalid font \(fontName) with size \(size). Using \(uiFont)")
        }
        
        return uiFont
    }
    
    /// Checks if font exists
    private class func doesFontExist(fontDescriptor: UIFontDescriptor) -> Bool {
        let fontName = fontDescriptor.fontAttributes[UIFontDescriptor.AttributeName.name] as? String ?? ""
        let fontSize = fontDescriptor.pointSize
        let font = UIFont(name: fontName, size: fontSize)
        return font != nil
    }
}
