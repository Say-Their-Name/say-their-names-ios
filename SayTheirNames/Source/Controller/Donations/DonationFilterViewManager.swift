//
//  DonationFilterViewManager.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class DonationFilterViewManager: CollectionViewManager<SingleSection, DonationFilter> {
    
    private let filters: [DonationFilter] = [
        .all,
        .victims,
        .protesters,
        .businesses
    ]
    
    override func configure(with collectionView: UICollectionView) {
        super.configure(with: collectionView)
        set(filters)
    }
}
