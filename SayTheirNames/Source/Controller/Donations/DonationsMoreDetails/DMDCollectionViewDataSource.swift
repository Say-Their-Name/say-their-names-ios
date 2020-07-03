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

// MARK: - Data Source
extension DonationsMoreDetailsController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = sectionAtIndex(section) else {
            return 0
        }
        
        if section == .socialMedia {
            return data.entity.hashtags.count
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = sectionAtIndex(indexPath.section) else {
            let cell: UICollectionViewCell = collectionView.dequeueCell(for: indexPath)
            return cell
        }
        
        switch section {
        // Title Section
        case DonationSectionLayoutKind.title:
            let titleCell: DMDTitleCell = collectionView.dequeueCell(for: indexPath)
            titleCell.setTitle(data.entity.title)
            return titleCell
            
        // Decription Section
        case DonationSectionLayoutKind.description:
            let textCell: DMDTextContentCell = collectionView.dequeueCell(for: indexPath)
            textCell.setContent(text: data.entity.description)
            return textCell
            
        // Outcome Section
        case DonationSectionLayoutKind.outcome:
            let textCell: DMDTextContentCell = collectionView.dequeueCell(for: indexPath)
            textCell.setContent(text: data.entity.description)
            return textCell
            
        // Social Media Hashtags Section
        case DonationSectionLayoutKind.socialMedia:
            let hashtagCell: HashtagViewCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            let hashtag = data.entity.hashtags[indexPath.row]
            hashtagCell.setupHashtag(hashtag)
            return hashtagCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let emptyView = { () -> UICollectionReusableView in
            let view: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(forKind: self.emptyKind, for: indexPath)
            return view
        }
        
        guard let section = sectionAtIndex(indexPath.section) else {
            return emptyView()
        }
        
        switch kind {
        case DonationsMoreDetailsController.photoSupplementaryView:
            // PhotoSupplementaryView
            let photoView: DMDPhotoSupplementaryView = collectionView.dequeueReusableSupplementaryView(forKind: kind,
                                                                                                       for: indexPath)
            switch data.entity.type?.id {
            case DonationTypes.movement.id:
                photoView.configure(withURLString: data.entity.bannerImagePath)
            default:
                photoView.configure(withURLString: data.entity.person?.images.first?.personURL)
            }
            
            return photoView
            
        case DonationsMoreDetailsController.sectionTitleSupplementaryView:
            // SectionTitleSupplementaryView
            let titleView: DMDSectionTitleSupplementaryView = collectionView.dequeueReusableSupplementaryView(forKind: kind,
                                                                                                              for: indexPath)
            switch section {
            case DonationSectionLayoutKind.description:
                titleView.setTitle(text: L10n.description.localizedUppercase)
            case DonationSectionLayoutKind.outcome:
                titleView.setTitle(text: L10n.Person.outcome.localizedUppercase)
            case DonationSectionLayoutKind.socialMedia:
                titleView.setTitle(text: L10n.Person.hashtags.localizedUppercase)
            default:
                return emptyView()
            }
            
            return titleView
            
        default:
            return emptyView()
        }
    }
    
}
