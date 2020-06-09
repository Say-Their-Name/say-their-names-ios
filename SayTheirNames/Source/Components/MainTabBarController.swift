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
        tabBar.layer.borderColor = UIColor(asset: STNAsset.Color.tabBarBorder).cgColor
        tabBar.clipsToBounds = true
        tabBar.backgroundColor = UIColor(asset: STNAsset.Color.background)
        tabBar.barTintColor = UIColor(asset: STNAsset.Color.tabBarBarTint)
        tabBar.tintColor = UIColor(asset: STNAsset.Color.tabBarTint)
        tabBar.unselectedItemTintColor = UIColor(asset: STNAsset.Color.tabBarUnselectedItemTint)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.STN.tabButtonTitle], for: .normal)
    }
    
    fileprivate func setupNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = UIColor(asset: STNAsset.Color.navBarBackground)//black
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor(asset: STNAsset.Color.navBarForeground),
            NSAttributedString.Key.font: UIFont.STN.navBarTitle
        ]
        appearance.titleTextAttributes = attrs as [NSAttributedString.Key: Any]
        
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
                                    
        homeNC.tabBarItem.image = UIImage(asset: STNAsset.Image.gallery)
        homeNC.tabBarItem.title = Strings.home
                
        donationsNC.tabBarItem.image = UIImage(asset: STNAsset.Image.heart)
        donationsNC.tabBarItem.selectedImage = UIImage(asset: STNAsset.Image.heartActive)
        donationsNC.tabBarItem.title = Strings.donations
                       
        petitionsNC.tabBarItem.image = UIImage(asset: STNAsset.Image.petition)
        petitionsNC.tabBarItem.selectedImage = UIImage(asset: STNAsset.Image.petitionActive)
        petitionsNC.tabBarItem.title = Strings.petitions
                
        aboutNC.tabBarItem.image = UIImage(asset: STNAsset.Image.settings)
        aboutNC.tabBarItem.selectedImage = UIImage(asset: STNAsset.Image.settingsActive)
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
       tabBar.layer.borderColor = UIColor(asset: STNAsset.Color.tabBarBorder).cgColor
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

extension MainTabBarController: DeepLinkHandle {
    func handle(deepLink: DeepLink) {
        Log.print(deepLink)

        if type(of: deepLink) == HomeDeepLink.self {
            self.selectedIndex = 0
        }
        else if type(of: deepLink) == DonationsDeepLink.self {
            self.selectedIndex = 1
        }
        else if type(of: deepLink) == PetitionsDeepLink.self {
                self.selectedIndex = 2
        }
        else if type(of: deepLink) == AboutDeepLink.self {
            self.selectedIndex = 3
        }
    }
}
