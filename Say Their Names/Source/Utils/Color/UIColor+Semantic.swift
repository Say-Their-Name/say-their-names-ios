//
//  UIColor+Semantic.swift
//  Say Their Names
//
//  Created by John Watson on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension UIColor {

    // MARK: LocationCell
    static let stn_locationCellBackground = color(named: "locationCellBackground")
    static let stn_locationCellForegroundSelected = color(named: "locationCellForegroundSelected")
    static let stn_locationCellForegroundDeselected = color(named: "locationCellForegroundDeselected")
    static let stn_locationCellBorder = color(named: "locationCellBorder")

    // MARK: MainTabBar
    static let stn_mainTabBarTint = color(named: "mainTabBarTint")
    static let stn_mainTabBarBarTint = color(named: "mainTabBarBarTint")
    static let stn_mainTabBarUnselectedItemTint = color(named: "mainTabBarUnselectedItemTint")

    // MARK: CustomNavigationBar
    static let stn_customNavigationBarBackground = color(named: "customNavigationBarBackground")
    static let stn_customNavigationBarForeground = color(named: "customNavigationBarForeground")

    // MARK: Donate button
    static let stn_donateButtonBackground = color(named: "donateButtonBackground")
    static let stn_donateButtonForeground = color(named: "donateButtonForeground")

    private static func color(named name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            fatalError("Failed to find semantic color named \"\(name)\". Please check the \"colors\" folder in the asset catalog to make sure color exists.")
        }
        return color
    }
}
