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
        
        let locationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: locationLayout)
        locationCollectionView.contentInsetAdjustmentBehavior = .always
        return locationCollectionView
    }()
    
    lazy var peopleCollectionView: UICollectionView = {
        let peopleLayout = UICollectionViewFlowLayout()
        peopleLayout.scrollDirection = .vertical
        peopleLayout.sectionInset = Self.PeopleSectionInsets
        
        let peopleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: peopleLayout)
        peopleCollectionView.contentInsetAdjustmentBehavior = .always
        return peopleCollectionView
    }()
    
    let bookmarkButton: UIButton = {
        let bookmarkButton = UIButton(type: .custom)
        let bookmarkImage = UIImage(named: "white-bookmark")
        bookmarkButton.setImage(bookmarkImage, for: .normal)
        return bookmarkButton
    }()
    
    let searchButton: UIButton = {
        let searchButton = UIButton(type: .custom)
        let searchImage = UIImage(named: "white-search")
        searchButton.setImage(searchImage, for: .normal)
        return searchButton
    }()
    
    let separator: UIView! = {
        let separator = UIView()
        separator.backgroundColor = .systemGray6
        return separator
    }()
    
    func safeWidth(for collectionView: UICollectionView) -> CGFloat {
        let width = collectionView.frame.width -
            collectionView.safeAreaInsets.left -
            collectionView.safeAreaInsets.right -
            collectionView.layoutMargins.left -
            collectionView.layoutMargins.right
        
        let flowLayoutMargins: CGFloat
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayoutMargins = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        }
        else {
            flowLayoutMargins = 0
        }
        
        return width - flowLayoutMargins
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
        customNavigationBar.anchor(
            superView: self,
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            size: .init(width: 0, height: Self.CustomNavigationBarHeight))
        collections.anchor(
            superView: self,
            top: customNavigationBar.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor)
        
        locationCollectionView.anchor(
            superView: collections,
            top: collections.topAnchor,
            leading: collections.leadingAnchor,
            trailing: collections.trailingAnchor,
            size: .init(width: 0, height: Self.PeopleCollectionViewHeight))
        separator.anchor(
            superView: collections,
            top: locationCollectionView.bottomAnchor,
            leading: collections.leadingAnchor,
            trailing: collections.trailingAnchor,
            size: .init(width: 0, height: Self.SeparatorHeight))
        peopleCollectionView.anchor(
            superView: collections,
            top: separator.bottomAnchor,
            leading: collections.leadingAnchor,
            bottom: collections.bottomAnchor,
            trailing: collections.trailingAnchor)
    }
    
    private func createCustomNavigationBarLayout() {
        let bar = customNavigationBar
        let label = UILabel()
        label.text = "SAY THEIR NAME"
        label.textColor = .white
        label.font = UIFont.STN.bannerTitle
        let buttonStack = UIStackView(arrangedSubviews: [bookmarkButton,searchButton])
        buttonStack.spacing = 8
        buttonStack.distribution = .fillEqually
        
        label.anchor(superView: bar, leading: bar.leadingAnchor, bottom: bar.bottomAnchor, padding: .init(left: 16, bottom: 16))
        bar.addSubview(buttonStack)
        [bookmarkButton, searchButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: Self.ButtonSize.height).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Self.ButtonSize.width).isActive = true
        }
        buttonStack.anchor(superView: bar, trailing: bar.trailingAnchor, padding: .init(right: 16))
        buttonStack.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true

    }

    // MARK: - Constants
    static let CustomNavigationBarHeight: CGFloat = 70
    static let PeopleCollectionViewHeight: CGFloat = 70
    static let ButtonSize: CGSize = .init(width: 40, height: 40)
    static let CustomNavBarMargin: CGFloat = 16
    static let SeparatorHeight: CGFloat = 1
    static let LocationsSectionInsets = UIEdgeInsets(left: 16, right: 16)
    static let PeopleSectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
}
