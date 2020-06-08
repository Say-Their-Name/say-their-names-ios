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
        let horizontalPadding: CGFloat = 27
        
        // UICollectionViewCompositionalLayout in a layout provider
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int,
            _ : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            
            // Later Feature
            // Outcome Section
            if FeatureFlags.dmdOutcomeSectionEnabled && sectionIndex == DonationSectionLayoutKind.outcome.rawValue {
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: horizontalPadding, bottom: 0.0, trailing: horizontalPadding)
                
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

            switch sectionIndex {
            // Title section layout
            case DonationSectionLayoutKind.title.rawValue:
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 30.0, leading: horizontalPadding, bottom: 20.0, trailing: horizontalPadding)
                
                // Photo Supplementary View
                let photoViewSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(420))
                let photoView =
                    NSCollectionLayoutBoundarySupplementaryItem(layoutSize: photoViewSize,
                                                                elementKind: DonationsMoreDetailsController.photoSupplementaryView,
                                                                alignment: .top)
                
                // Button Supplementary View
                let buttonViewSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let buttonView =
                    NSCollectionLayoutBoundarySupplementaryItem(layoutSize: buttonViewSize,
                                                                elementKind: DonationsMoreDetailsController.donationButtonSupplementaryView,
                                                                alignment: .bottom)
                buttonView.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: horizontalPadding, bottom: 0.0, trailing: horizontalPadding)
                
                section.supplementariesFollowContentInsets = false
                section.boundarySupplementaryItems = [photoView, buttonView]
                
                return section
                
            // Description section layout
            case DonationSectionLayoutKind.description.rawValue:
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: horizontalPadding, bottom: 0.0, trailing: horizontalPadding)
                
                // Supplementary
                let titleViewSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(22.5))
                let titleView =
                    NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleViewSize,
                                                                elementKind: DonationsMoreDetailsController.sectionTitleSupplementaryView,
                                                                alignment: .top)
                
                section.boundarySupplementaryItems = [titleView]
                
                return section

            // Social Media Hashtags section layout
            case DonationSectionLayoutKind.socialMedia.rawValue:
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(130.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(31.0))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = NSCollectionLayoutSpacing.fixed(9.0)
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 18.0, leading: horizontalPadding, bottom: 18.0, trailing: horizontalPadding)
                section.orthogonalScrollingBehavior = .continuous
                
                // Supplementary
                let titleViewSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(22.5))
                let titleView =
                    NSCollectionLayoutBoundarySupplementaryItem(layoutSize: titleViewSize,
                                                                elementKind: DonationsMoreDetailsController.sectionTitleSupplementaryView,
                                                                alignment: .top)
                
                section.boundarySupplementaryItems = [titleView]
                
                return section
            
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
        config.interSectionSpacing = 28
        
        layout.configuration = config
        return layout
    }
}
