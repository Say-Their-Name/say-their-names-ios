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
        case outcome = 2
        case socialMedia = 3
    }
    
    // MARK: - Supplementary View Kind
    static let photoSupplementaryView = "photo"
    static let donationButtonSupplementaryView = "donationButton"
    static let sectionTitleSupplementaryView = "sectionTitle"
    
    // MARK: - Property
    var donation: Donation?
    
    private var dataSource: UICollectionViewDiffableDataSource<DonationSectionLayoutKind, Donation>!
    private let navigationBarTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.STN.navBarTitle
    ]

    // MARK: - View
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: Self.donationMoreDetailsCVLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubview()
        setupNavigationBarItems()
        configureDataSource()
    
        if let donation = donation {
            setupDataSource(for: donation)
        } else {
            getMOCData()
        }
    }
    
    // MARK: - Class Method
    private func configureSubview() {
        view.backgroundColor = UIColor.STN.white
        
        collectionView.fillSuperview(superView: view, padding: .zero)
        collectionView.register(DMDTitleCell.self, forCellWithReuseIdentifier: DMDTitleCell.reuseIdentifier)
        collectionView.register(DMDPhotoSupplementaryView.self,
                                forSupplementaryViewOfKind: DonationsMoreDetailsController.photoSupplementaryView,
                                withReuseIdentifier: DMDPhotoSupplementaryView.reuseIdentifier)
        collectionView.register(DMDDonationButtonSupplementaryView.self,
                                forSupplementaryViewOfKind: DonationsMoreDetailsController.donationButtonSupplementaryView,
                                withReuseIdentifier: DMDDonationButtonSupplementaryView.reuseIdentifier)
        collectionView.register(DMDSectionTitleSupplementaryView.self,
                                forSupplementaryViewOfKind: DonationsMoreDetailsController.sectionTitleSupplementaryView,
                                withReuseIdentifier: DMDSectionTitleSupplementaryView.reuseIdentifier)
    }
    
    private func setupNavigationBarItems() {
        // TODO: Once Theme.swift/etc gets added this may not be required
        navigationController?.navigationBar.titleTextAttributes = self.navigationBarTextAttributes
        
        // TODO: Localization
        self.title = "Say Their Names".uppercased()
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white,
         NSAttributedString.Key.font: UIFont(name: "Karla-Regular", size: 19) ?? UIFont.systemFont(ofSize: 17)]

        let dismissButton = UIButton(type: .system)
        dismissButton.setImage(UIImage(named: "Close Icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismissButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        dismissButton.addTarget(self, action: #selector(dismissAction(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dismissButton)
        
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(named: "share_white")?.withRenderingMode(.alwaysOriginal), for: .normal)
        shareButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        shareButton.addTarget(self, action: #selector(shareAction(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black
    }
    
    private func setupDataSource(for donation: Donation) {
        var snapshot = NSDiffableDataSourceSnapshot<DonationSectionLayoutKind, Donation>()
        
        snapshot.appendSections([.title]) // , .description, .outcome, .socialMedia
        snapshot.appendItems([donation])
        
        self.dataSource.apply(snapshot)
    }
    
    private func getMOCData() {
        self.service.network.fetchDonations { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let page):
                guard let donation = page.all.first else { return }
                self.setupDataSource(for: donation)
            case .failure(let error):
                Log.print(error)
            }
        }
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
        dataSource =
            UICollectionViewDiffableDataSource<DonationSectionLayoutKind, Donation>(collectionView: collectionView,
                                                                                    cellProvider: { (collectionView,
                                                                                        indexPath,
                                                                                        donation) -> UICollectionViewCell? in
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
        
        // Create DataSource for supplementary view
        dataSource.supplementaryViewProvider = { [weak self] (collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            guard let self = self else { return nil }
            
            switch kind {
                
            // PhotoSupplementaryView
            case DonationsMoreDetailsController.photoSupplementaryView:
                guard let photoView = collectionView
                    .dequeueReusableSupplementaryView(ofKind: DonationsMoreDetailsController.photoSupplementaryView,
                                                      withReuseIdentifier: DMDPhotoSupplementaryView.reuseIdentifier,
                                                      for: indexPath) as? DMDPhotoSupplementaryView else {
                                                        fatalError("Cannot create new view") }
                
                guard let person = self.dataSource.itemIdentifier(for: indexPath)?.person else {
                    return nil
                }
                
                photoView.configure(person)
                
                return photoView
                
            // DonationButtonSupplementaryView
            case DonationsMoreDetailsController.donationButtonSupplementaryView:
                guard let buttonView = collectionView
                    .dequeueReusableSupplementaryView(ofKind: DonationsMoreDetailsController.donationButtonSupplementaryView,
                                                      withReuseIdentifier: DMDDonationButtonSupplementaryView.reuseIdentifier,
                                                      for: indexPath) as? DMDDonationButtonSupplementaryView else {
                                                        fatalError("Cannot create new view") }

                buttonView.setButtonPressed {
                    // Donation Button Action
                }
                
                return buttonView
                
            // SectionTitleSupplementaryView
            case DonationsMoreDetailsController.sectionTitleSupplementaryView:
                guard let titleView = collectionView
                    .dequeueReusableSupplementaryView(ofKind: DonationsMoreDetailsController.sectionTitleSupplementaryView,
                                                      withReuseIdentifier: DMDSectionTitleSupplementaryView.reuseIdentifier,
                                                      for: indexPath) as? DMDSectionTitleSupplementaryView else {
                                                        fatalError("Cannot create new view") }
                
                switch indexPath.section {
                case DonationSectionLayoutKind.description.rawValue:
                    titleView.setTitle(text: "description".uppercased())
                case DonationSectionLayoutKind.outcome.rawValue:
                    titleView.setTitle(text: "outcome".uppercased())
                default:
                    break
                }

                return titleView
            default:
                return nil
            }
        }
    }
}
