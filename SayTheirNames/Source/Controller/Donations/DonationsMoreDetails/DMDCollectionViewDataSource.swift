//
//  DMDCollectionViewDataSource.swift
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

// MARK: - DataSource
extension DonationsMoreDetailsController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == DonationSectionLayoutKind.socialMedia.rawValue {
            return donation.hashTags.count
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        // Title Section
        case DonationSectionLayoutKind.title.rawValue:
            guard let titleCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DMDTitleCell.reuseIdentifier,
                for: indexPath) as? DMDTitleCell else {
                    fatalError("Cannot create new cell")
            }
            
            // Configure cell
            titleCell.configure(for: donation)
            return titleCell
            
        // Decription Section
        case DonationSectionLayoutKind.description.rawValue:
            guard let textCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DMDTextContentCell.reuseIdentifier,
                for: indexPath) as? DMDTextContentCell else {
                    fatalError("Cannot create new cell")
            }
            
            // Configure cell
            textCell.setContent(text: donation.description)
            return textCell
            
        // Outcome Section
        case DonationSectionLayoutKind.outcome.rawValue:
            guard let textCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DMDTextContentCell.reuseIdentifier,
                for: indexPath) as? DMDTextContentCell else {
                    fatalError("Cannot create new cell")
            }
            
            // Configure cell
            textCell.setContent(text: donation.description)
            textCell.isHidden = !FeatureFlags.dmdOutcomeSectionEnabled
            return textCell
            
        // Social Media Hashtags Section
        case DonationSectionLayoutKind.socialMedia.rawValue:
            guard let hashtagCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HashtagViewCollectionViewCell.reuseIdentifier,
                for: indexPath) as? HashtagViewCollectionViewCell else {
                    fatalError("Cannot create new cell")
            }
            
            let hashtag = donation.hashTags[indexPath.row]
            hashtagCell.setupHashtag(hashtag)
            return hashtagCell
            
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellIdentifier, for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case DonationsMoreDetailsController.photoSupplementaryView:
            // PhotoSupplementaryView
            if let photoView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DMDPhotoSupplementaryView.reuseIdentifier,
                for: indexPath) as? DMDPhotoSupplementaryView {
                
                switch donation.type?.id {
                case DonationTypes.movement.id:
                    photoView.configure(withURLString: donation.bannerImagePath)
                default:
                    photoView.configure(withURLString: donation.person?.images.first?.personURL)
                }
                
                return photoView
            }
    
        case DonationsMoreDetailsController.sectionTitleSupplementaryView:
            // SectionTitleSupplementaryView
            if let titleView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DMDSectionTitleSupplementaryView.reuseIdentifier,
                for: indexPath) as? DMDSectionTitleSupplementaryView {
                
                switch indexPath.section {
                case DonationSectionLayoutKind.description.rawValue:
                    titleView.setTitle(text: L10n.description.localizedUppercase)
                case DonationSectionLayoutKind.outcome.rawValue:
                    titleView.setTitle(text: L10n.Person.outcome.localizedUppercase)
                    titleView.isHidden = !FeatureFlags.dmdOutcomeSectionEnabled
                case DonationSectionLayoutKind.socialMedia.rawValue:
                    titleView.setTitle(text: L10n.Person.hashtags.localizedUppercase)
                default:
                    return UICollectionReusableView(frame: .zero)
                }
                
                return titleView
            }
        default:
            return collectionView.dequeueReusableSupplementaryView(ofKind: emptyKind, withReuseIdentifier: emptyViewIdentifier, for: indexPath)
        }
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: emptyKind, withReuseIdentifier: emptyViewIdentifier, for: indexPath)
    }
    
}
