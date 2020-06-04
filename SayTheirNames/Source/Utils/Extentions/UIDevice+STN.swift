//
//  UIDevice+STN.swift
//  SayTheirNames
//
//  Created by evilpenguin on 5/30/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - STNDevice

public typealias STNDevice = UIDevice
extension STNDevice {
    // MARK: - Class Methods
    class var screenSize: STNSize {
        let bounds = UIScreen.main.nativeBounds
        switch bounds.height {
            case 960.0: return .small(frame: bounds)    // iPhone 4/4s
            case 1136.0: return .medium(frame: bounds)  // iPhone 5/5S/5C
            case 1334.0: return .large(frame: bounds)   // iPhone 6/6S/7/8
            case 2208.0: return .xlarge(frame: bounds)  // iPhone 6+/7+/8+
            case 2436.0: return .x(frame: bounds)       // iPhone X
            default: break
        }
        
        return .unknown()
    }
}
