//
//  ColorResource.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/30/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - UIColor

extension UIColor {
    
    /// A collection of common colors
    static let stn: STN = .init()
}

extension UIColor {
    
    final class STN {
        let black: UIColor = { UIColor.hexColor(0x101010) }()
        let white: UIColor = { UIColor.hexColor(0xffffff) }()
        let gray: UIColor = { UIColor.hexColor(0x9C9C9C) }()
    }
}
