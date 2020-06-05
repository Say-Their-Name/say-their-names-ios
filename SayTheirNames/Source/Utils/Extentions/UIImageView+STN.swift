//
//  UIImageView+STN.swift
//  SayTheirNames
//
//  Created by Juan Olivera on 6/4/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import SDWebImage

public extension UIImageView {
    func populate(withURL url: String) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
      self.sd_setImage(
        with: URL(string: url),
        placeholderImage: UIImage(named: "image-placeholder")
      )
    }
}
