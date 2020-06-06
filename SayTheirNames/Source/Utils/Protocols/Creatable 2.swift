//
//  Creatable.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

protocol Creatable: UIView {
    init()
}

extension Creatable {
    static func create(handleCreation: (Self) -> Void = { _ in }) -> Self {
        let view = Self.init()
        handleCreation(view)
        return view
    }

    func configure(handleConfiguration: (Self) -> Void) -> Self {
        handleConfiguration(self)
        return self
    }
}

extension UIView: Creatable {}
