//
//  FontResource.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/30/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - STNFontResource

public typealias STNFontResource = UIFont
extension STNFontResource {
    
    // MARK: - Class methods
    public class var exampleFont: UIFont {
        return self._font(name: "Karla-Regular", size: 14.0)
    }
    
    // MARK: - Private methods
    fileprivate class func _font(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size)
        else { return UIFont.systemFont(ofSize: size) }
        
        return font
    }
}
