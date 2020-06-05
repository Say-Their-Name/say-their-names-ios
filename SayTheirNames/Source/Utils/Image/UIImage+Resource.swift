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
        static let bookmark: UIImage = UIImage(named: String.image.bookmark) ?? UIImage()
        static let bookmarkActive: UIImage = UIImage(named: String.image.bookmarkActive) ??  UIImage()
        static let heartActive: UIImage = UIImage(named: String.image.heartActive) ??  UIImage()
        static let petitionActive: UIImage = UIImage(named: String.image.petitionActive) ??  UIImage()
        static let settingsActive: UIImage = UIImage(named: String.image.settingsActive) ??  UIImage()
        static let whiteBookmark: UIImage = UIImage(named: String.image.whiteBookmark) ??  UIImage()
        static let whiteSearch: UIImage = UIImage(named: String.image.whiteSearch) ??  UIImage()
        static let imagePlaceHolder: UIImage = UIImage(named: String.image.imagePlaceholder) ??  UIImage()
        static let manInRedJacket: UIImage = UIImage(named: String.image.manInRedJacket) ??  UIImage()
    }
}
