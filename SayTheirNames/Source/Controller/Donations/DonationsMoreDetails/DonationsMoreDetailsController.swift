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
    var donation: Donation!
    
    private let emptyKind = "empty-kind"
    private let emptyCellIdentifier = "empty-cell-identifier"
    private let emptyViewIdentifier = "empty-view-identifier"
    
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
        collectionView.dataSource = self
    }
    
    // MARK: - Class Method
    private func configureSubview() {
        view.backgroundColor = UIColor.STN.white
        
        collectionView.fillSuperview(superView: view, padding: .zero)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: emptyCellIdentifier)
        collectionView.register(DMDTitleCell.self, forCellWithReuseIdentifier: DMDTitleCell.reuseIdentifier)
        collectionView.register(DMDTextContentCell.self, forCellWithReuseIdentifier: DMDTextContentCell.reuseIdentifier)
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: emptyKind,
                                withReuseIdentifier: emptyViewIdentifier)
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

    // MARK: - Button Action
    @objc func dismissAction(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func shareAction(_ sender: Any) {
        // TODO: Share button action
    }
    
}

extension DonationsMoreDetailsController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
            textCell.setContent(text: donation.outcome)
            return textCell
            
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: emptyCellIdentifier, for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case DonationsMoreDetailsController.photoSupplementaryView:
            // PhotoSupplementaryView
            if let photoView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DMDPhotoSupplementaryView.reuseIdentifier,
                for: indexPath) as? DMDPhotoSupplementaryView {
                
                let person = donation.person
                photoView.configure(person)
                return photoView
            }
            
        case DonationsMoreDetailsController.donationButtonSupplementaryView:
            // DonationButtonSupplementaryView
            if let buttonView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DMDDonationButtonSupplementaryView.reuseIdentifier,
                for: indexPath) as? DMDDonationButtonSupplementaryView {
                
                buttonView.setButtonPressed {
                    // Donation Button Action
                }
                
                return buttonView
            }
    
        case DonationsMoreDetailsController.sectionTitleSupplementaryView:
            // SectionTitleSupplementaryView
            if let titleView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DMDSectionTitleSupplementaryView.reuseIdentifier,
                for: indexPath) as? DMDSectionTitleSupplementaryView {
                
                switch indexPath.section {
                case DonationSectionLayoutKind.description.rawValue:
                    titleView.setTitle(text: "description".uppercased())
                case DonationSectionLayoutKind.outcome.rawValue:
                    titleView.setTitle(text: "outcome".uppercased())
                case DonationSectionLayoutKind.socialMedia.rawValue:
                    titleView.setTitle(text: "social media hashtags".uppercased())
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
