//
//  UIFont++.swift
//  SayTheirNames
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension UIFont {

    static func karla(weight: UIFont.Weight, size: CGFloat) -> UIFont? {
        switch weight {
        case .bold: return UIFont(name: "Karla-Rold", size: size)
        default: return UIFont(name: "Karla-Regular", size: size)

        }
    }
}
