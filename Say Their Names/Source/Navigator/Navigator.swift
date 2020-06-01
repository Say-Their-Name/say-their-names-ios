//
//  Navigator.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class Navigator: BaseService {
    public var window: UIWindow!
    public lazy var rootViewController: MainTabBarController = MainTabBarController(service: self.service)
    
    // MARK: - Public methods
    
    public func installWindow(_ window: UIWindow?, withWindowScene: UIWindowScene) {
        guard let window = window else { return }
        
        self.window = window
        self.window.windowScene = withWindowScene
        self.window.rootViewController = self.rootViewController
        self.window.makeKeyAndVisible()
    }
    
    public func setNeedsStatusBarAppearanceUpdate() {
        self.rootViewController.setNeedsStatusBarAppearanceUpdate()
    }
}
