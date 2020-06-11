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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == DonationSectionLayoutKind.socialMedia.rawValue {
            return data.entity.hashtags.count
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        // Title Section
        case DonationSectionLayoutKind.title.rawValue:
            let titleCell: DMDTitleCell = collectionView.dequeueCell(for: indexPath)
            titleCell.setTitle(data.entity.title)
            return titleCell
            
        // Decription Section
        case DonationSectionLayoutKind.description.rawValue:
            let textCell: DMDTextContentCell = collectionView.dequeueCell(for: indexPath)
            textCell.setContent(text: data.entity.description)
            return textCell
            
        // Outcome Section
        case DonationSectionLayoutKind.outcome.rawValue:
            let textCell: DMDTextContentCell = collectionView.dequeueCell(for: indexPath)
            textCell.setContent(text: data.entity.description)
            textCell.isHidden = !FeatureFlags.dmdOutcomeSectionEnabled
            return textCell
            
        // Social Media Hashtags Section
        case DonationSectionLayoutKind.socialMedia.rawValue:
            let hashtagCell: HashtagViewCollectionViewCell = collectionView.dequeueCell(for: indexPath)
            let hashtag = data.entity.hashtags[indexPath.row]
            hashtagCell.setupHashtag(hashtag)
            return hashtagCell
            
        default:
            let cell: UICollectionViewCell = collectionView.dequeueCell(for: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
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
        default:
            let view: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(forKind: emptyKind, for: indexPath)
            return view
        }
    }
    
}
