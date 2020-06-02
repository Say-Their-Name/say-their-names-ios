//
//  MainTabBar.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    // Params
    private let shadowRadius: CGFloat = 15
    private let shadowOpacity: Float = 1
    private let shadowOffset: CGSize = .init(width: 0, height: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupTabBarStyle()
        setupTabBar()
        setupTabViews()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    fileprivate func setupTabBarStyle() {
        tabBar.isTranslucent = false
        tabBar.layer.borderWidth = 0.9
        tabBar.clipsToBounds = true
        tabBar.barTintColor = .stn_mainTabBarBarTint
        tabBar.layer.borderColor = UIColor.stn_mainTabBarBarTint.cgColor
        tabBar.tintColor = .stn_mainTabBarTint
        tabBar.unselectedItemTintColor = .stn_mainTabBarUnselectedItemTint
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Karla-Regular", size: 11)!], for: .normal)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            tabBar.layer.borderColor = UIColor.stn_mainTabBarBarTint.cgColor
        }
    }


    @objc fileprivate func setupTabViews() {
        let homeController = HomeController()
        let homeNC = UINavigationController(rootViewController: homeController)
        
        let donationsController = DonationsController()
        let donationsNC = UINavigationController(rootViewController: donationsController)
        
        let petitionsController = PetitionsController()
        let petitionsNC = UINavigationController(rootViewController: petitionsController)

        homeNC.isNavigationBarHidden = true
        homeNC.tabBarItem.image = #imageLiteral(resourceName: "gallery")
        homeNC.tabBarItem.title = "Home"
        
        donationsNC.isNavigationBarHidden = true
        donationsNC.tabBarItem.image = #imageLiteral(resourceName: "heart")
        donationsNC.tabBarItem.title = "Donations"

        petitionsNC.isNavigationBarHidden = true
        petitionsNC.tabBarItem.image = #imageLiteral(resourceName: "edit")
        petitionsNC.tabBarItem.title = "Petitions"
        
        viewControllers = [homeNC, donationsNC, petitionsNC]
    }

    func setupTabBar() {
        // modifiy tab bar item insets
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        }
    }
}
