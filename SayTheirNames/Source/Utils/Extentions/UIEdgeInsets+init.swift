//
//  UIEdgeInsets+init.swift
//  SayTheirNames
//
//  Created by Berta Devant on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.init()
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
    
    static let medium: UIEdgeInsets = UIEdgeInsets(top: Theme.Components.Padding.medium,
                                                   left: Theme.Components.Padding.medium,
                                                   bottom: Theme.Components.Padding.medium,
                                                   right: Theme.Components.Padding.medium)
}
