//
//  Reusable.swift
//  SayTheirNames
//
//  Created by Leonardo Garcia  on 02/06/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// Provides a default `reuseIdentifier` to the entities that conform to it.
protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
