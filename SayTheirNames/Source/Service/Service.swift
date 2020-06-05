//
//  Services.swift
//  SayTheirNames
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

protocol Servicing {
    var navigator: Navigator { get }
    var image: ImageService { get }
    var dateFormatter: DateFormatterService { get }
    var network: NetworkRequestor { get }
}
/// This is a core class that holds all instances responsible for logic
final class Service: Servicing {
    lazy private(set) var navigator = Navigator(service: self)
    lazy private(set) var image = ImageService()
    lazy private(set) var dateFormatter = DateFormatterService()
    lazy private(set) var network = NetworkRequestor()
    
    // MARK: - Init
    init() {
        Log.mode = .all
        Log.print("STN Version: \(Bundle.versionBuildString)")
        Log.print("Starting Services")
    }
}
