//
//  DonationsMoreDetailsController.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/5/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class DonationsMoreDetailsController: BaseViewController {
    // MARK: - Section Layout Kind
    enum DonationSectionLayoutKind: Int, CaseIterable {
        case title = 0
        case description = 1
        case socialMedia = 2
    }
    
    // MARK: - Property
    var donation: Donation?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - View
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: Self.donationMoreDetailsCVLayout)
        
        return collectionView
    }()
}
