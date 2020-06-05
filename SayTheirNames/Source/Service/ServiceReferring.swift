//
//  BaseServiceiewController.swift
//  SayTheirNames
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// Protocol describing a type that can hold a reference to `Servicing`
protocol ServiceReferring {
    var service: Servicing { get }
    init(service: Servicing)
}
