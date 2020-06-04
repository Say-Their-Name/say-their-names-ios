//
//  UIImageView+STN.swift
//  SayTheirNames
//
//  Created by Juan Olivera on 6/4/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import Kingfisher

public extension UIImageView {
    func populate(withURL url: String) {
        self.kf.indicatorType = .activity
        self.kf.setImage(
          with: URL(string: url),
          placeholder: UIImage(named: "image-placeholder")
        )
    }
}
