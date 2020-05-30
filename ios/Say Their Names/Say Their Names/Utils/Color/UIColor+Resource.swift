//
//  ColorResource.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/30/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// A collection of common colors
    enum STN {
        static let black: UIColor = { UIColor.hexColor(0x101010) }()
        static let white: UIColor = { UIColor.hexColor(0xffffff) }()
        static let gray: UIColor = { UIColor.hexColor(0x9C9C9C) }()


		// MARK: - Labels

		static let primaryLabel : UIColor = UIColor(named: "primaryLabel") ?? #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 1)

		static let secondaryLabel : UIColor = UIColor(named: "secondaryLabel") ?? #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 0.47)
    }

}
