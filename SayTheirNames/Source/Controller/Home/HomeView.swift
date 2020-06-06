//
//  HomeView.swift
//  SayTheirNames
//
//  Created by Joseph A. Wardell on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class HomeView: UIView {

    // MARK: - Properties
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
        let headerLayout = makeHeaderComposition()
        let peopleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: headerLayout)
        peopleCollectionView.contentInsetAdjustmentBehavior = .always
        return peopleCollectionView
    }()

    weak var peopleDataSource: PersonCollectionViewDataSourceHelper?

    // MARK: - Methods
    func makeHeaderComposition() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (sectionIndex: Int,
            layoutEnviroment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            guard let sections = self?.peopleDataSource?.dataSource.snapshot().sectionIdentifiers else {return nil}
            let deviceWidth = layoutEnviroment.traitCollection.horizontalSizeClass
            switch sections[sectionIndex] {

            case .header:

                let groupWidth: CGFloat = deviceWidth == .compact ? 0.95 : 1.0

                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))

                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

                let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWidth),
                                                             heightDimension: .estimated(170))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
                let spacing = CGFloat(10)
                group.interItemSpacing = .fixed(spacing)
                let headerSection = NSCollectionLayoutSection(group: group)
                headerSection.orthogonalScrollingBehavior = .groupPaging
                headerSection.interGroupSpacing = spacing
                return headerSection
            case .main:
                //the amount of columns shown in the group dependants upon screen rotation

                let columns = deviceWidth == .compact ? 2 : 4
                let insets = deviceWidth == .compact ? Self.PeopleSectionInsetsPortraint : Self.PeopleSecrtionInsetsLandscape
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))

                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

                let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitem: layoutItem, count: columns)
                group.interItemSpacing = .fixed(10)
                let mainSection = NSCollectionLayoutSection(group: group)
                mainSection.contentInsets = insets
                return mainSection
            }
        })
        layout.configuration.interSectionSpacing = 10
        return layout
    }
    
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
        collections.backgroundColor = .systemBackground
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
            top: separator.safeAreaLayoutGuide.bottomAnchor,
            leading: collections.safeAreaLayoutGuide.leadingAnchor,
            bottom: collections.safeAreaLayoutGuide.bottomAnchor,
            trailing: collections.safeAreaLayoutGuide.trailingAnchor)
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
    static let PeopleSectionInsetsPortraint = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
    static let PeopleSecrtionInsetsLandscape = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
}
