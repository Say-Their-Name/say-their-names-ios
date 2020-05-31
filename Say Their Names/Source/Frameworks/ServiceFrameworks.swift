//
//  ServiceFrameworks.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit
import Firebase

// MARK: - ServiceFrameworks

typealias ServiceFrameworks = Service
extension ServiceFrameworks {
    public func startFrameworks() {
        // Start FirebaseApp
        FirebaseApp.configure()
    }
}
