//
//  ColorResource.swift
//  SayTheirNames
//
//  Created by evilpenguin on 5/30/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// A collection of common colors
    enum STN {

        static let black: UIColor = UIColor(named: "black") ?? .black
        static let white: UIColor = UIColor(named: "white") ?? .white
        static let gray: UIColor = UIColor(named: "grey") ?? .gray
        
		// MARK: - Applications

        static let tint: UIColor = UIColor(named: "tint") ?? .black

		// MARK: - Labels

        static let primaryLabel: UIColor = UIColor(named: "primaryLabel") ?? .label

        static let secondaryLabel: UIColor = UIColor(named: "secondaryLabel") ?? .secondaryLabel
    }

}
