//
//  UIButton++.swift
//  SayTheirNames
//
//  Created by Onyekachi Ezeoke on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(image: UIImage?) {
        self.init(frame: .zero)
        setImage(image, for: .normal)
    }
}
