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
        self.locationCollectionView = UICollectionView(frame: .zero, collectionViewLayout:locationLayout)
        
        let peopleLayout = UICollectionViewFlowLayout()
        peopleLayout.scrollDirection = .vertical
        self.peopleCollectionView = UICollectionView(frame: .zero, collectionViewLayout:peopleLayout)

        let searchButton = UIButton(type: .custom)
        let searchImage = UIImage(named: "Simple Search Icon")!
        searchButton.setImage(searchImage, for: .normal)
        self.searchButton = searchButton
        
        super.init(frame: frame)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        createLayout()
        
        backgroundColor = .red
    }
    
    private var hasLayedOutSubviews = false
    private func createLayout() {
        guard !hasLayedOutSubviews else { return }
        hasLayedOutSubviews = true
        
        
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
        
        [customNavBar,
         locationCollectionView,
         peopleCollectionView,
         header,
         searchButton].forEach {
            $0!.translatesAutoresizingMaskIntoConstraints = false
        }

        [customNavBar,
         locationCollectionView,
         peopleCollectionView].forEach {
            addSubview($0!)
        }
        
        NSLayoutConstraint.activate([
            customNavBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            customNavBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: Self.CustomNavBarHeight),
            
            header.centerXAnchor.constraint(equalTo: customNavBar.centerXAnchor),
            header.centerYAnchor.constraint(equalTo: customNavBar.centerYAnchor),
            
            searchButton.widthAnchor.constraint(equalToConstant: Self.SearchButtonSize),
            searchButton.heightAnchor.constraint(equalToConstant: Self.SearchButtonSize),
            searchButton.trailingAnchor.constraint(equalTo: customNavBar.trailingAnchor, constant: -Self.CustomNavBarMargin),
            searchButton.centerYAnchor.constraint(equalTo: customNavBar.centerYAnchor)
        ])
    }
    
    static let CustomNavBarHeight : CGFloat = 70
    static let SearchButtonSize : CGFloat = 45
    static let CustomNavBarMargin : CGFloat = 16
}
