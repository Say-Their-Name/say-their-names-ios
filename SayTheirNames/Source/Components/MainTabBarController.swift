//
//  MainTabBar.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    let service: Service
    
    // Params
    private let defaultBarTint: UIColor = .white
    private let defaultTint = UIColor.black
    private let defaultUnselectedTint = #colorLiteral(red: 0.3803921569, green: 0.3882352941, blue: 0.4666666667, alpha: 0.5681668134)


    private let shadowRadius: CGFloat = 15
    private let shadowOpacity: Float = 1
    private let shadowOffset: CGSize = .init(width: 0, height: 10)

    private var launchScreen: LaunchScreen?
    
    required init?(coder aDecoder: NSCoder) { fatalError("") }
    init(service: Service) {
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
        tabBar.layer.borderColor = #colorLiteral(red: 0.9451505829, green: 0.9451505829, blue: 0.9451505829, alpha: 1)
        tabBar.clipsToBounds = true
        tabBar.backgroundColor = .white
        tabBar.barTintColor = defaultBarTint
        tabBar.tintColor = defaultTint
        tabBar.unselectedItemTintColor = defaultUnselectedTint
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Karla-Regular", size: 11)!], for: .normal)
    }

    @objc fileprivate func setupTabViews() {
        let homeController = HomeController(service: self.service)
        let homeNC = UINavigationController(rootViewController: homeController)
        
        let donationsController = DonationsController(service: self.service)
        let donationsNC = UINavigationController(rootViewController: donationsController)
        
        let petitionsController = PetitionsController(service: self.service, shouldInitWithNib: false)
        let petitionsNC = UINavigationController(rootViewController: petitionsController)
        
        let settingsController = SettingsController(service: self.service) 
        let settingsNC = UINavigationController(rootViewController: settingsController)
            
        homeNC.isNavigationBarHidden = true
        homeNC.tabBarItem.image = #imageLiteral(resourceName: "gallery")
        homeNC.tabBarItem.title = "Home"
        
        donationsNC.isNavigationBarHidden = true
        donationsNC.tabBarItem.image = #imageLiteral(resourceName: "heart")
        donationsNC.tabBarItem.selectedImage = UIImage(named: "heart_active")
        donationsNC.tabBarItem.title = "Donations"
               
        petitionsNC.isNavigationBarHidden = true
        petitionsNC.tabBarItem.image = #imageLiteral(resourceName: "petition")
        petitionsNC.tabBarItem.selectedImage = UIImage(named: "petition_active")
        petitionsNC.tabBarItem.title = "Petitions"
        
        settingsNC.isNavigationBarHidden = true
        settingsNC.tabBarItem.image = #imageLiteral(resourceName: "settings")
        settingsNC.tabBarItem.selectedImage = UIImage(named: "settings_active")
        settingsNC.tabBarItem.title = "Settings"
        
        viewControllers = [homeNC, donationsNC, petitionsNC, settingsNC]
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
}
