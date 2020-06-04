//
//  HomeView.swift
//  SayTheirNames
//
//  Created by Joseph A. Wardell on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class HomeView: UIView {

    let customNavigationBar: UIView = {
        let customNavigationBar = UIView()
        customNavigationBar.backgroundColor = .black
        return customNavigationBar
    }()
    
    lazy var locationCollectionView: UICollectionView = {
        let locationLayout = UICollectionViewFlowLayout()
        locationLayout.scrollDirection = .horizontal
        locationLayout.sectionInsetReference = .fromContentInset
        locationLayout.sectionInset = Self.LocationsSectionInsets
        
        let locationCollectionView = UICollectionView(frame: .zero, collectionViewLayout:locationLayout)
        locationCollectionView.contentInsetAdjustmentBehavior = .always
        return locationCollectionView
    }()
    
    lazy var peopleCollectionView: UICollectionView = {
        let peopleLayout = UICollectionViewFlowLayout()
        peopleLayout.scrollDirection = .vertical
        peopleLayout.sectionInset = Self.PeopleSectionInsets
        
        let peopleCollectionView = UICollectionView(frame: .zero, collectionViewLayout:peopleLayout)
        peopleCollectionView.contentInsetAdjustmentBehavior = .always
        return peopleCollectionView
    }()
    
    let searchButton: UIButton = {
        let searchButton = UIButton(type: .custom)
        let searchImage = UIImage(named: "Simple Search Icon")
        searchButton.setImage(searchImage, for: .normal)
        return searchButton
    }()
    
    let separator: UIView! = {
        let separator = UIView()
        separator.backgroundColor = .systemGray6
        return separator
    }()
    
    var hideable: [UIView] {
        [customNavigationBar, locationCollectionView, peopleCollectionView, separator]
    }
        
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        createLayout()
        backgroundColor = .black

    }
        
    private var hasLayedOutSubviews = false
    private func createLayout() {
        guard !hasLayedOutSubviews else { return }
        hasLayedOutSubviews = true
                
        createCustomNavigationBarLayout()
        addSubview(customNavigationBar)

        let collections = UIView()
        addSubview(collections)
        
        locationCollectionView.backgroundColor = .systemBackground
        peopleCollectionView.backgroundColor = .systemBackground
        
        [locationCollectionView,
        peopleCollectionView,
        separator].forEach {
            collections.addSubview($0)
        }
        
        // all subviews should use custom constraints
        [customNavigationBar,
         locationCollectionView,
         peopleCollectionView,
         searchButton,
         collections,
         separator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            customNavigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            customNavigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: Self.CustomNavigationBarHeight),
                        
            searchButton.widthAnchor.constraint(equalToConstant: Self.SearchButtonSize),
            searchButton.heightAnchor.constraint(equalToConstant: Self.SearchButtonSize),
            searchButton.trailingAnchor.constraint(equalTo: customNavigationBar.trailingAnchor, constant: -Self.CustomNavBarMargin),
            searchButton.centerYAnchor.constraint(equalTo: customNavigationBar.centerYAnchor),
            
            collections.leadingAnchor.constraint(equalTo: leadingAnchor),
            collections.trailingAnchor.constraint(equalTo: trailingAnchor),
            collections.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            collections.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            locationCollectionView.leadingAnchor.constraint(equalTo: collections.leadingAnchor),
            locationCollectionView.trailingAnchor.constraint(equalTo: collections.trailingAnchor),
            locationCollectionView.topAnchor.constraint(equalTo: collections.topAnchor),
            locationCollectionView.heightAnchor.constraint(equalToConstant: Self.PeopleCollectionViewHeight),
            
            separator.leadingAnchor.constraint(equalTo: collections.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: collections.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: Self.SeparatorHeight),
            separator.topAnchor.constraint(equalTo: locationCollectionView.bottomAnchor),
            
            peopleCollectionView.leadingAnchor.constraint(equalTo: collections.leadingAnchor),
            peopleCollectionView.trailingAnchor.constraint(equalTo: collections.trailingAnchor),
            peopleCollectionView.topAnchor.constraint(equalTo: separator.bottomAnchor),
            peopleCollectionView.bottomAnchor.constraint(equalTo: collections.bottomAnchor)
        ])
    }
    
    private func createCustomNavigationBarLayout() {
        
        let logo = UIImageView(image: UIImage(named: "logo"))
        let label = UILabel()
        label.text = "SayTheirName"
        label.textColor = .white
        label.font = UIFont.STN.bannerTitle
        
        let header = UIStackView(arrangedSubviews: [logo, label])
        header.axis = .horizontal
        header.alignment = .center
        header.spacing = 8
        customNavigationBar.addSubview(header)
        
        header.translatesAutoresizingMaskIntoConstraints = false
        
        customNavigationBar.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            header.centerXAnchor.constraint(equalTo: customNavigationBar.centerXAnchor),
            header.centerYAnchor.constraint(equalTo: customNavigationBar.centerYAnchor),
        ])
    }

    // MARK:- Constants
    static let CustomNavigationBarHeight : CGFloat = 70
    static let PeopleCollectionViewHeight : CGFloat = 70
    static let SearchButtonSize : CGFloat = 45
    static let CustomNavBarMargin : CGFloat = 16
    static let SeparatorHeight : CGFloat = 1
    
    static let LocationsSectionInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    static let PeopleSectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
}
