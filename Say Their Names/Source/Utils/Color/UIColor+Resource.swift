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

		static let black: UIColor = UIColor(named: "black") ?? #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
		static let white: UIColor = UIColor(named: "white") ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		static let gray: UIColor = UIColor(named: "grey") ?? #colorLiteral(red: 0.6117647059, green: 0.6117647059, blue: 0.6117647059, alpha: 1)


		// MARK: - Applications

		static let tint : UIColor = UIColor(named: "tint") ?? #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 1)


		// MARK: - Labels

		static let primaryLabel : UIColor = UIColor(named: "primaryLabel") ?? #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 1)

		static let secondaryLabel : UIColor = UIColor(named: "secondaryLabel") ?? #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 0.47)
    }

}
