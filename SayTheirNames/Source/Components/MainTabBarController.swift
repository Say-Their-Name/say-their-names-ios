//
//  MainTabBar.swift
//  SayTheirNames
//
//  Copyright (c) 2020 Say Their Names Team (https://github.com/Say-Their-Name)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {    
    // Params
    private var launchScreen: LaunchScreen?
    
    required init?(coder aDecoder: NSCoder) { fatalError("") }
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupTabBarStyle()
        setupNavigationBarStyle()
        setupTabBar()
        setupTabViews()
        showLaunchScreen()	
        view.isAccessibilityElement = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // To-Do: move this logic to after data is fetched from back-end, or when we are ready to reveal the content
        removeLaunchScreen()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let launchScreen = launchScreen {
            view.bringSubviewToFront(launchScreen)
        }
    }
    
    fileprivate func setupTabBarStyle() {
        tabBar.isTranslucent = true
        tabBar.layer.borderWidth = 0.9
        tabBar.layer.borderColor = UIColor.STN.tabBarBorder.cgColor
        tabBar.clipsToBounds = true
        tabBar.backgroundColor = UIColor.STN.background
        tabBar.barTintColor = UIColor.STN.tabBarBarTint
        tabBar.tintColor = UIColor.STN.tabBarTint
        tabBar.unselectedItemTintColor = UIColor.STN.tabBarUnselectedItemTint
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.STN.tabButtonTitle], for: .normal)
    }
    
    fileprivate func setupNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = UIColor.STN.navBarBackground//black
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.STN.navBarForeground,
            NSAttributedString.Key.font: UIFont.STN.navBarTitle
        ]
        appearance.titleTextAttributes = attrs
        
        UINavigationBar.appearance().standardAppearance = appearance
    }

    @objc fileprivate func setupTabViews() {
        let homeController = HomeController()
        let homeNC = UINavigationController(rootViewController: homeController)
        
        let donationsController = DonationsController()
        let donationsNC = UINavigationController(rootViewController: donationsController)
        
        let petitionsController = PetitionsController()
        let petitionsNC = UINavigationController(rootViewController: petitionsController)
        
        let aboutController = AboutController()
        let aboutNC = UINavigationController(rootViewController: aboutController)
                                    
        homeNC.tabBarItem.image = UIImage(asset: STNImage.gallery)
        homeNC.tabBarItem.title = Strings.home
                
        donationsNC.tabBarItem.image = UIImage(asset: STNImage.heart)
        donationsNC.tabBarItem.selectedImage = UIImage(asset: STNImage.heartActive)
        donationsNC.tabBarItem.title = Strings.donations
                       
        petitionsNC.tabBarItem.image = UIImage(asset: STNImage.petition)
        petitionsNC.tabBarItem.selectedImage = UIImage(asset: STNImage.petitionActive)
        petitionsNC.tabBarItem.title = Strings.petitions
                
        aboutNC.tabBarItem.image = UIImage(asset: STNImage.settings)
        aboutNC.tabBarItem.selectedImage = UIImage(asset: STNImage.settingsActive)
        aboutNC.tabBarItem.title = Strings.about
        
        viewControllers = [homeNC, donationsNC, petitionsNC, aboutNC]
    }

    func setupTabBar() {
        // modifiy tab bar item insets
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: Theme.Components.Padding.medium, left: 0, bottom: 0, right: 0)
        }
    }
    private func updateCGColors() {
       tabBar.layer.borderColor = UIColor.STN.tabBarBorder.cgColor
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateCGColors()
        tabBar.setNeedsDisplay()
    }
}

private extension MainTabBarController {
    
    func showLaunchScreen() {
        guard let launchView = LaunchScreen.createFromNib() else {
            return
        }
        view.addSubview(launchView)
        launchView.frame = view.bounds
        launchScreen = launchView
    }
    
    func removeLaunchScreen() {
        guard let launchView = launchScreen else { return }

        launchView.animate(completion: {
            launchView.removeFromSuperview()
            self.launchScreen = nil
        })
    }
}
