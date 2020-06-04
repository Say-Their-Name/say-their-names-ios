//
//  UIImageButton.swift
//  Say Their Names
//
//  Created by Onyekachi Ezeoke on 04/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class UIImageButton: UIButton {
    init(_ image: UIImage?) {
        super.init(frame: .zero)
        setImage(image, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
