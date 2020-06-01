//
//  Services.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// This is a core class that holds all instances responsible for logic
final class Service {
    lazy private(set) var navigator = Navigator(service: self)
    lazy private(set) var image = ImageService()
    
    let firebaseIntegration: FirebaseIntegration // TODO: should be hidden behind a protocol
    
    // MARK: - Init
    init() {
        self.firebaseIntegration = FirebaseIntegration()
        
        Log.mode = .all
        Log.print("STN Version: \(Bundle.versionBuildString)")
        Log.print("Starting Services")
        
        // Just for testing
        self.firebaseIntegration.getPeople { (result: Result<[Person], Error>) in
            print(result)
        }
    }
}
