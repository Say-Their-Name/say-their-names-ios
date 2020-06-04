//
//  BaseServiceiewController.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

/// Protocol describing a type that can hold a reference to `Service`
protocol ServiceReferring {
    var service: Service { get }
    init(service: Service)
}
