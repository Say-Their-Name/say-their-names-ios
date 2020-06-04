//
//  STNImages.swift
//  SayTheirNames
//
//  Created by Juan Olivera on 6/4/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import Kingfisher

struct STNImage {
    public static func populate(_ imageView: UIImageView, withURL url: String) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
          with: URL(string: url),
          placeholder: UIImage(named: "image-placeholder")
        )
    }
}
