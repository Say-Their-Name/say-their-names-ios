//
//  HomeView.swift
//  Say Their Names
//
//  Created by Joseph A. Wardell on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class HomeView: UIView {

    var customNavBar: UIView!
    var locationCollectionView: UICollectionView!
    var peopleCollectionView: UICollectionView!
    var searchButton: UIButton!
    
    required init?(coder: NSCoder) { fatalError("This should never be called") }
    override init(frame: CGRect) {
        
        let customNavBar = UIView()
        customNavBar.backgroundColor = .black
        self.customNavBar = customNavBar
        
        let locationLayout = UICollectionViewFlowLayout()
        locationLayout.scrollDirection = .horizontal
        locationLayout.sectionInsetReference = .fromContentInset
        locationLayout.sectionInset = Self.LocationsSectionInsets
        let locationCollectionView = UICollectionView(frame: .zero, collectionViewLayout:locationLayout)
        locationCollectionView.tag = 0
        locationCollectionView.contentInsetAdjustmentBehavior = .always
        self.locationCollectionView = locationCollectionView
        
        let peopleLayout = UICollectionViewFlowLayout()
        peopleLayout.scrollDirection = .vertical
        peopleLayout.sectionInset = Self.PeopleSectionInsets
        let peopleCollectionView = UICollectionView(frame: .zero, collectionViewLayout:peopleLayout)
        peopleCollectionView.tag = 1
        peopleCollectionView.contentInsetAdjustmentBehavior = .always
        self.peopleCollectionView = peopleCollectionView
        
        let searchButton = UIButton(type: .custom)
        let searchImage = UIImage(named: "Simple Search Icon")!
        searchButton.setImage(searchImage, for: .normal)
        self.searchButton = searchButton
        
        super.init(frame: frame)

        backgroundColor = .black
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        createLayout()
        
    }
    
    private var hasLayedOutSubviews = false
    private func createLayout() {
        guard !hasLayedOutSubviews else { return }
        hasLayedOutSubviews = true
        
        // Custom Nav Bar
        let logo = UIImageView(image: UIImage(named: "logo"))
        let label = UILabel()
        label.text = "SAY THEIR NAME"
        label.textColor = .white
        label.font = UIFont.STN.bannerTitle
        
        let header = UIStackView(arrangedSubviews: [logo, label])
        header.axis = .horizontal
        header.alignment = .center
        header.spacing = 8
        customNavBar.addSubview(header)
        
        customNavBar.addSubview(searchButton)
        
        addSubview(customNavBar)

        // Collections
        let collections = UIView()
        addSubview(collections)
        
        let separator = UIView()
        separator.backgroundColor = .systemGray6

        locationCollectionView.backgroundColor = .systemBackground
        peopleCollectionView.backgroundColor = .systemBackground
        
        [locationCollectionView,
        peopleCollectionView,
        separator].forEach {
            collections.addSubview($0)
        }
        
        // all subviews should use custom constraints
        [customNavBar,
         locationCollectionView,
         peopleCollectionView,
         header,
         searchButton,
         collections,
         separator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            customNavBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            customNavBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: Self.CustomNavBarHeight),
            
            header.centerXAnchor.constraint(equalTo: customNavBar.centerXAnchor),
            header.centerYAnchor.constraint(equalTo: customNavBar.centerYAnchor),
            
            searchButton.widthAnchor.constraint(equalToConstant: Self.SearchButtonSize),
            searchButton.heightAnchor.constraint(equalToConstant: Self.SearchButtonSize),
            searchButton.trailingAnchor.constraint(equalTo: customNavBar.trailingAnchor, constant: -Self.CustomNavBarMargin),
            searchButton.centerYAnchor.constraint(equalTo: customNavBar.centerYAnchor),
            
            collections.leadingAnchor.constraint(equalTo: leadingAnchor),
            collections.trailingAnchor.constraint(equalTo: trailingAnchor),
            collections.topAnchor.constraint(equalTo: customNavBar.bottomAnchor),
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
    
    // MARK:- Constants
    static let CustomNavBarHeight : CGFloat = 70
    static let PeopleCollectionViewHeight : CGFloat = 70
    static let SearchButtonSize : CGFloat = 45
    static let CustomNavBarMargin : CGFloat = 16
    static let SeparatorHeight : CGFloat = 1
    
    static let LocationsSectionInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    static let PeopleSectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
}
