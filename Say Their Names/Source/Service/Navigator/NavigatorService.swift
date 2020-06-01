//
//  Navigator.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class NavigatorService: BaseService {
    
    lazy private(set) var window = UIWindow()
    lazy private(set) var rootViewController = MainTabBarController(service: self.service)
    
    // MARK: - Public methods
    
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
