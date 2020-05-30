//
//  UIFont+STN.swift
//  Say Their Names
//
//  Created by Marina Gornostaeva on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

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
