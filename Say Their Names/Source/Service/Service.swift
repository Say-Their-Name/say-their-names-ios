//
//  Services.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - Service

final class Service {
    public lazy var navigator = Navigator(service: self)
    
    // MARK: - Init
    init() {
        Log.mode = .all
        Log.print("STN Version: \(Bundle.versionBuildString)")
        Log.print("Starting Services")
        
        self.startFrameworks()
    }
}
