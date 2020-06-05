//
//  DonationsMoreDetailsController.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/5/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class DonationsMoreDetailsController: BaseViewController {
    // MARK: - Section Layout Kind
    enum DonationSectionLayoutKind: Int, CaseIterable {
        case title = 0
        case description = 1
        case socialMedia = 2
    }
    
    // MARK: - Property
    var donation: Donation?
    var dataSource: UICollectionViewDiffableDataSource<DonationSectionLayoutKind, Donation>!

    // MARK: - View
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: Self.donationMoreDetailsCVLayout)
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubview()
        configureDataSource()
        
        if let donation = donation {
            var snapshot = NSDiffableDataSourceSnapshot<DonationSectionLayoutKind, Donation>()
            snapshot.appendItems([donation])
            
            dataSource.apply(snapshot)
        } else {
            // make moc data
        }
    }
    
    // MARK: - Class Method
    private func configureSubview() {
        collectionView.fillSuperview(superView: view, padding: .zero)
    }
    
    // MARK: - DataSource
    private func configureDataSource() {
        // Create DataSource for cells
        dataSource = UICollectionViewDiffableDataSource<DonationSectionLayoutKind, Donation> (
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, donation) -> UICollectionViewCell? in
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
                default:
                    return nil
                }
        })
    }
}
