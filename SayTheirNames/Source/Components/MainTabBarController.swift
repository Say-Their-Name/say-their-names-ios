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
    let service: Servicing
    
    // Params
    private let defaultBarTint: UIColor = .white
    private let defaultTint = UIColor.black
    private let defaultUnselectedTint = UIColor(red: 0.3803921569, green: 0.3882352941, blue: 0.4666666667, alpha: 0.5681668134)

    private let shadowRadius: CGFloat = 15
    private let shadowOpacity: Float = 1
    private let shadowOffset: CGSize = .init(width: 0, height: 10)

    private var launchScreen: LaunchScreen?
    
    required init?(coder aDecoder: NSCoder) { fatalError("") }
    init(service: Servicing) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupTabBarStyle()
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
        tabBar.layer.borderColor = UIColor(red: 0.9451505829, green: 0.9451505829, blue: 0.9451505829, alpha: 1).cgColor
        tabBar.clipsToBounds = true
        tabBar.backgroundColor = .white
        tabBar.barTintColor = defaultBarTint
        tabBar.tintColor = defaultTint
        tabBar.unselectedItemTintColor = defaultUnselectedTint
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.STN.tabButtonTitle], for: .normal)
    }

    @objc fileprivate func setupTabViews() {
        let homeController = HomeController(service: self.service)
        let homeNC = UINavigationController(rootViewController: homeController)
        
        let donationsController = DonationsController(service: self.service)
        let donationsNC = UINavigationController(rootViewController: donationsController)
        
        let petitionsController = PetitionsController(service: self.service)
        let petitionsNC = UINavigationController(rootViewController: petitionsController)
        
        let aboutController = AboutController(service: self.service)
        let aboutNC = UINavigationController(rootViewController: aboutController)
            
        homeNC.isNavigationBarHidden = true
        homeNC.tabBarItem.image = UIImage(named: "gallery")
        homeNC.tabBarItem.title = Strings.home
        homeNC.tabBarItem.accessibilityIdentifier = AccessibilityId.homeTabBarButton
        
        donationsNC.isNavigationBarHidden = true
        donationsNC.tabBarItem.image = UIImage(named: "heart")
        donationsNC.tabBarItem.selectedImage = UIImage(named: "heart_active")
        donationsNC.tabBarItem.title = Strings.donations
        donationsNC.tabBarItem.accessibilityIdentifier = AccessibilityId.donationsTabBarButton
               
        petitionsNC.isNavigationBarHidden = true
        petitionsNC.tabBarItem.image = UIImage(named: "petition")
        petitionsNC.tabBarItem.selectedImage = UIImage(named: "petition_active")
        petitionsNC.tabBarItem.title = Strings.petitions
        petitionsNC.tabBarItem.accessibilityIdentifier = AccessibilityId.petitionsTabBarButton
        
        aboutNC.tabBarItem.title = Strings.about
        aboutNC.tabBarItem.selectedImage = UIImage(named: "settings_active")
        aboutNC.tabBarItem.image = UIImage(named: "settings")
        aboutNC.isNavigationBarHidden = true
        aboutNC.tabBarItem.accessibilityIdentifier = AccessibilityId.settingsTabBarButton
        
        viewControllers = [homeNC, donationsNC, petitionsNC, aboutNC]
    }

    func setupTabBar() {
        // modifiy tab bar item insets
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        }
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
    
    struct AccessibilityId {
        static let homeTabBarButton = "homeTabBarButton"
        static let donationsTabBarButton = "donationsTabBarButton"
        static let petitionsTabBarButton = "petitionsTabBarButton"
        static let settingsTabBarButton = "settingsTabBarButton"
    }
}
