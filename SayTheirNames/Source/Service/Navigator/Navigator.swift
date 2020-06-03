//
//  Navigator.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class Navigator: ServiceReferring {
    weak var service: Service?
    
    let window: UIWindow
    let rootViewController: MainTabBarController
    
    // MARK: - Public methods
    
    init(service: Service) {
        self.service = service
        self.rootViewController = MainTabBarController(service: service)
        self.window = UIWindow()
    }
    
    func installSceneInWindow(_ scene: UIWindowScene) -> UIWindow {
        self.window.frame = scene.coordinateSpace.bounds
        self.window.windowScene = scene
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
        
        return self.window
    }
    
    func setNeedsStatusBarAppearanceUpdate() {
        self.rootViewController.setNeedsStatusBarAppearanceUpdate()
    }
}
