//
//  ColorResource.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/30/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - STNColorResource

public typealias STNColorResource = UIColor
extension STNColorResource {
    
    // MARK: - Class methods
    public class var stnBlack: UIColor {
        return self.hexColor(0x101010)
    }
    
    public class var stnWhite: UIColor {
        return self.hexColor(0xffffff)
    }
    
    public class var stnGray: UIColor {
        return self.hexColor(0x9C9C9C)
    }
}


