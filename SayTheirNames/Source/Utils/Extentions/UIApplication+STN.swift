//
//  UIApplication+STN.swift
//  SayTheirNames
//
//  Created by evilpenguin on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension UIApplication {
    class var stn: STNAppDelegate {
        return UIApplication.shared.delegate as! STNAppDelegate
    }
}
