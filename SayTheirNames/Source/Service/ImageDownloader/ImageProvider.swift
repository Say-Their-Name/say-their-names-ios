//
//  ImageProvider.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// Protocol that suggests the conformants provide a `UIImage`
protocol ImageProvider {
    var image: UIImage? { get }
}
