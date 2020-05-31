//
//  UIViewController+TabBar.swift
//  Say Their Names
//
//  Created by christopher downey on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//


import UIKit

extension UIViewController {
    func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func revealTabBar() {
        tabBarController?.tabBar.isHidden = false
    }
}
