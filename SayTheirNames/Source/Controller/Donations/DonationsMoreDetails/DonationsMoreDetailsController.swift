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
    
    let navigationBarTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.STN.navBarTitle
    ]

    // MARK: - View
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: Self.donationMoreDetailsCVLayout)
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubview()
        setupNavigationBarItems()
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
    
    private func setupNavigationBarItems() {
        // TODO: Once Theme.swift/etc gets added this may not be required
        navigationController?.navigationBar.titleTextAttributes = self.navigationBarTextAttributes
        
        // TODO: Localization
        self.title = "Say Their Names".uppercased()
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white,
         NSAttributedString.Key.font: UIFont(name: "Karla-Regular", size: 19) ?? UIFont.systemFont(ofSize: 17)]
        
        let dismissActionGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAction(_:)))
        let shareActionGesture = UITapGestureRecognizer(target: self, action: #selector(shareAction(_:)))

        let dismissButton = UIButton(type: .system)
        dismissButton.addGestureRecognizer(dismissActionGesture)
        dismissButton.setImage(UIImage(named: "Close Icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismissButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dismissButton)
        
        let shareButton = UIButton(type: .system)
        shareButton.addGestureRecognizer(shareActionGesture)
        shareButton.setImage(UIImage(named: "share_white")?.withRenderingMode(.alwaysOriginal), for: .normal)
        shareButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black
    }
    
    // MARK: - Button Action
    @objc func dismissAction(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func shareAction(_ sender: Any) {
        // TODO: Share button action
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
