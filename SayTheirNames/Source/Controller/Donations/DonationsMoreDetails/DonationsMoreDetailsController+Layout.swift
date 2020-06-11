//
//  DonationsMoreDetailsController+Layout.swift
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

// MARK: - UICollectionViewLayout
extension DonationsMoreDetailsController {
    static var donationMoreDetailsCVLayout: UICollectionViewLayout {
        let horizontalPadding: CGFloat = Theme.Screens.DonationDetails.horizontalPadding
        
        // UICollectionViewCompositionalLayout in a layout provider
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int,
            _ : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            
            // Later Feature
            // Outcome Section
            if FeatureFlags.dmdOutcomeSectionEnabled && sectionIndex == DonationSectionLayoutKind.outcome.rawValue {
                return DonationsMoreDetailsController.outcomeLayout()
            }

            switch sectionIndex {
            // Title section layout
            case DonationSectionLayoutKind.title.rawValue:
                return DonationsMoreDetailsController.titleLayout()
                
            // Description section layout
            case DonationSectionLayoutKind.description.rawValue:
                return DonationsMoreDetailsController.descriptionLayout()

            // Social Media Hashtags section layout
            case DonationSectionLayoutKind.socialMedia.rawValue:
                return DonationsMoreDetailsController.hashtagLayout()
            
            default:
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: horizontalPadding, bottom: 0.0, trailing: horizontalPadding)

                return section
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = Theme.Screens.DonationDetails.intersectionSpacing
        
        layout.configuration = config
        return layout
    }
    
}

// MARK: Layouts

extension DonationsMoreDetailsController {
    
    // Outcome Layout
    static func outcomeLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0.0,
                                                        leading: Theme.Screens.DonationDetails.horizontalPadding,
                                                        bottom: 0.0,
                                                        trailing: Theme.Screens.DonationDetails.horizontalPadding)
        
        // Supplementary
        let titleViewSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(22.5))
        let titleView =
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleViewSize,
                                                        elementKind: DonationsMoreDetailsController.sectionTitleSupplementaryView,
                                                        alignment: .top)
        
        section.boundarySupplementaryItems = [titleView]
        
        return section
    }
    
    // Title Layout
    static func titleLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 30.0,
                                                        leading: Theme.Screens.DonationDetails.horizontalPadding,
                                                        bottom: 20.0,
                                                        trailing: Theme.Screens.DonationDetails.horizontalPadding)
        
        // Photo Supplementary View
        let photoViewSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(420))
        let photoView =
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: photoViewSize,
                                                        elementKind: DonationsMoreDetailsController.photoSupplementaryView,
                                                        alignment: .top)
        
        section.supplementariesFollowContentInsets = false
        section.boundarySupplementaryItems = [photoView]
        
        return section
    }
    
    // Description Layout
    static func descriptionLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: Theme.Components.Padding.small,
                                                        leading: Theme.Screens.DonationDetails.horizontalPadding,
                                                        bottom: Theme.Components.Padding.small,
                                                        trailing: Theme.Screens.DonationDetails.horizontalPadding)
        
        // Supplementary
        let titleViewSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(22.5))
        let titleView =
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleViewSize,
                                                        elementKind: DonationsMoreDetailsController.sectionTitleSupplementaryView,
                                                        alignment: .topLeading)
        
        section.boundarySupplementaryItems = [titleView]
        return section
    }
    
    // Hashtag Layout
    static func hashtagLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitem: item, count: 1)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: Theme.Components.Padding.small,
                                                        leading: Theme.Screens.DonationDetails.horizontalPadding,
                                                        bottom: Theme.Components.Padding.small,
                                                        trailing: Theme.Screens.DonationDetails.horizontalPadding)
        section.interGroupSpacing = Theme.Components.Padding.medium
        section.orthogonalScrollingBehavior = .continuous
        
        // Supplementary
        let titleViewSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(22.5))
        let titleView =
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleViewSize,
                                                        elementKind: DonationsMoreDetailsController.sectionTitleSupplementaryView,
                                                        alignment: .topLeading)
        
        section.boundarySupplementaryItems = [titleView]
        return section
    }
}
