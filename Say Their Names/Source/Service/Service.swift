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
    lazy private(set) var networkSession = NetworkSession<Data>()

    // MARK: - Init
    init() {
        Log.mode = .all
        Log.print("STN Version: \(Bundle.versionBuildString)")
        Log.print("Starting Services")
        
        self.networkSession.service = self
        
        // Tesging people
        self.networkSession.fetchAllPeople { (people, error) in
            
        }
    }
}
