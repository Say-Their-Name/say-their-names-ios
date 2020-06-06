//
//  DonationFilterViewManager.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// Responsible for managing the donation filters in the `UICollectionView`
final class DonationFilterViewManager: CollectionViewManager<SingleSection, DonationFilter> {
    
    private let filters: [DonationFilter] = [
        .all,
        .victims,
        .protesters,
        .businesses
    ]
    
    override func configure(with collectionView: UICollectionView) {
        super.configure(with: collectionView)

        // Populate collectionView
        set(filters)

        // Select first item
        let firstIndex = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: firstIndex, animated: false, scrollPosition: .left)
    }
}
