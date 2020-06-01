//
//  Services.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - Service

/// This is a core class that holds all instances responsible for logic ("services")

final class Service {
    lazy private(set) var navigator = NavigatorService(service: self)
    lazy private(set) var image = ImageService(service: self)

    // MARK: - Init
    init() {
        Log.mode = .all
        Log.print("STN Version: \(Bundle.versionBuildString)")
        Log.print("Starting Services")
        
        self.startFrameworks()
    }
}
