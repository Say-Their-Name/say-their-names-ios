//
//  HomeView.swift
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

final class HomeView: UIView {

    // MARK: - Properties

    private let navigationBarLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.sayTheirNames.uppercased()
        label.textColor = UIColor.STN.white

        return label
    }()
    
    let customNavigationBar: UIView = {
        let customNavigationBar = UIView()
        customNavigationBar.backgroundColor = UIColor.STN.black
        return customNavigationBar
    }()
    
    lazy private(set) var locationCollectionView: UICollectionView = {
        let locationLayout = UICollectionViewFlowLayout()
        locationLayout.scrollDirection = .horizontal
        locationLayout.sectionInsetReference = .fromContentInset
        let inset = Theme.Components.edgeMargin
        locationLayout.sectionInset = UIEdgeInsets(0, inset, 0, inset)
        let locationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: locationLayout)
        locationCollectionView.contentInsetAdjustmentBehavior = .always
        locationCollectionView.isHidden = !FeatureFlags.filtersEnabled
        return locationCollectionView
    }()
    
    lazy private(set) var peopleCollectionView: UICollectionView = {
        let headerLayout = makePeopleCollectionViewLayout()
        let peopleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: headerLayout)
        peopleCollectionView.contentInset.top = 20
        peopleCollectionView.contentInset.bottom = 20
        return peopleCollectionView
    }()

    weak var peopleDataSource: PersonCollectionViewDataSourceHelper?

    private static var horizontalPaddingBetween: CGFloat { Theme.Components.Padding.small }

    // MARK: - Methods
    private func makePeopleCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (sectionIndex: Int,
            layoutEnviroment: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in
            
            guard let sections = self?.peopleDataSource?.dataSource.snapshot().sectionIdentifiers else {return nil}
            let deviceWidth = layoutEnviroment.traitCollection.horizontalSizeClass

            let section: NSCollectionLayoutSection
            
            switch sections[sectionIndex] {

            case .carousel:
                let groupWidth: CGFloat = deviceWidth == .compact ? 0.75 : 0.4 // TODO: pick pretty numbers later, consult with UX

                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let height = Theme.Screens.Home.CellSize.carouselCardHeight
                let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWidth),
                                                             heightDimension: .absolute(height))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
                
                let headerSection = NSCollectionLayoutSection(group: group)
                headerSection.orthogonalScrollingBehavior = .groupPaging
                headerSection.interGroupSpacing = Self.horizontalPaddingBetween
                section = headerSection
            
            case .main:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)

                let height = Theme.Screens.Home.CellSize.peopleHeight
                let columns = deviceWidth == .compact ? Theme.Screens.Home.Columns.compactScreenWidth : Theme.Screens.Home.Columns.wideScreenWidth
                let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitem: layoutItem, count: columns)
                group.interItemSpacing = .fixed(Self.horizontalPaddingBetween)
                
                let mainSection = NSCollectionLayoutSection(group: group)
                section = mainSection
            }
            
            let inset = Theme.Components.edgeMargin
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: inset, bottom: 0, trailing: inset)
            
            return section
        })
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = Theme.Components.Padding.medium
        layout.configuration = config
        return layout
    }
    
    let bookmarkButton: UIButton = {
        let bookmarkImage = UIImage(named: "white-bookmark")
        let bookmarkButton = UIButton(image: bookmarkImage)
        bookmarkButton.accessibilityLabel = L10n.bookmark
        bookmarkButton.isHidden = !FeatureFlags.bookmarksEnabled
        return bookmarkButton
    }()
    
    let searchButton: UIButton = {
        let searchButton = UIButton(type: .custom)
        let searchImage = UIImage(named: "white-search")
        searchButton.setImage(searchImage, for: .normal)
        searchButton.accessibilityLabel = L10n.search
        return searchButton
    }()
    
    let separator: UIView! = {
        let separator = UIView()
        separator.backgroundColor = UIColor.STN.separator
        separator.isHidden = !FeatureFlags.filtersEnabled
        return separator
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        createLayout()
        backgroundColor = UIColor.STN.black // needed?
        
        styleLabels()
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
            size: Theme.Screens.Home.NavigationBar.size)
        collections.anchor(
            superView: self,
            top: customNavigationBar.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor)

        if FeatureFlags.filtersEnabled {
            locationCollectionView.anchor(
                superView: collections,
                top: collections.topAnchor,
                leading: collections.leadingAnchor,
                trailing: collections.trailingAnchor,
                size: Theme.Screens.Home.LocationView.size)
            
            separator.anchor(
                superView: collections,
                top: locationCollectionView.bottomAnchor,
                leading: collections.leadingAnchor,
                trailing: collections.trailingAnchor,
                size: Theme.Screens.Home.SeparatorView.size)
        }
        
        peopleCollectionView.anchor(
            superView: collections,
            top: FeatureFlags.filtersEnabled ? separator.safeAreaLayoutGuide.bottomAnchor : collections.topAnchor,
            leading: collections.leadingAnchor,
            bottom: collections.safeAreaLayoutGuide.bottomAnchor,
            trailing: collections.trailingAnchor)
    }
    
    private func createCustomNavigationBarLayout() {
        let bar = customNavigationBar

        let buttonStack = UIStackView(arrangedSubviews: [bookmarkButton,searchButton])
        buttonStack.spacing = Theme.Components.Padding.small
        buttonStack.distribution = .fillEqually
        
        navigationBarLabel.anchor(superView: bar,
                                  leading: bar.leadingAnchor,
                                  bottom: bar.bottomAnchor,
                                  padding: .init(left: Theme.Components.Padding.medium, bottom: Theme.Components.Padding.medium))
        bar.addSubview(buttonStack)
        [bookmarkButton, searchButton].forEach {
            $0.widthAnchor.constraint(equalToConstant: Theme.Components.Button.Size.medium.height).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Theme.Components.Button.Size.medium.width).isActive = true
        }
        buttonStack.anchor(superView: bar, trailing: bar.trailingAnchor, padding: .init(right: Theme.Components.Padding.medium))
        buttonStack.centerYAnchor.constraint(equalTo: navigationBarLabel.centerYAnchor).isActive = true
        
        navigationBarLabel.trailingAnchor.constraint(equalTo: buttonStack.leadingAnchor, constant: Theme.Components.Padding.tiny).isActive = true
    }

    private func styleLabels() {

        navigationBarLabel.font = UIFont.STN.bannerTitle
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            styleLabels()
        }
    }
}
