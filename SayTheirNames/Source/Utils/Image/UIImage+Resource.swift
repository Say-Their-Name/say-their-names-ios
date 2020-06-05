//
//  UIIcons+Resource.swift
//  SayTheirNames
//
//  Created by Visal Rajapakse on 6/5/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

//collection of icons used
extension UIImage{
    enum STN {
        static let bookmark: UIImage = UIImage(named: KIconNames.bookmarkLiteral) ?? #imageLiteral(resourceName: "bookmark_active")
        static let bookmarkActive: UIImage = UIImage(named: KIconNames.bookmarkActiveLiteral) ?? #imageLiteral(resourceName: "bookmark_active")
        static let heartActive: UIImage = UIImage(named: KIconNames.heartActiveLiteral) ?? #imageLiteral(resourceName: "heart_active")
        static let petitionActive: UIImage = UIImage(named: KIconNames.petitionActiveLiteral) ?? #imageLiteral(resourceName: "petition_active")
        static let settingsActive: UIImage = UIImage(named: KIconNames.settingsActiveLiteral) ?? #imageLiteral(resourceName: "settings_active")
        static let whiteBookmark: UIImage = UIImage(named: KIconNames.whiteBookmarkLiteral) ?? #imageLiteral(resourceName: "white-bookmark")
        static let whiteSearch: UIImage = UIImage(named: KIconNames.whiteSearchLiteral) ?? #imageLiteral(resourceName: "Simple Search Icon")
        static let imagePlaceHolder: UIImage = UIImage(named: KIconNames.imagePlaceholderLiteral) ?? #imageLiteral(resourceName: "image-placeholder")
        static let manInRedJacket: UIImage = UIImage(named: KIconNames.manInRedJacketLiteral) ?? #imageLiteral(resourceName: "man-in-red-jacket-1681010")
    }
}

// MARK: - Constants
struct KIconNames {
    static let bookmarkLiteral: String = "bookmark"
    static let bookmarkActiveLiteral: String = "bookmark_active"
    static let heartActiveLiteral: String = "heart_active"
    static let petitionActiveLiteral: String = "petition_active"
    static let settingsActiveLiteral: String = "settings_active"
    static let whiteBookmarkLiteral: String = "white-bookmark"
    static let whiteSearchLiteral: String = "white-search"
    static let imagePlaceholderLiteral: String = "image-placeholder"
    static let manInRedJacketLiteral: String = "man-in-red-jacket-1681010"
}
