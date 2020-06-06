//
//  DonationsCollectionViewManager.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class DonationsCollectionViewManager: CollectionViewManager<SingleSection, Donation> {
    
    override func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width
        let height = super.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath).height
        return CGSize(width: width, height: height)
    }
}
