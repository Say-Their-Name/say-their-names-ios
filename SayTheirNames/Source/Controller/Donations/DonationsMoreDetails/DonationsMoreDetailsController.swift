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
    
    internal let emptyKind = "empty-kind"
    internal let emptyCellIdentifier = "empty-cell-identifier"
    internal let emptyViewIdentifier = "empty-view-identifier"
    
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
    
    private let donationButtonContainerView = ButtonContainerView(frame: .zero)
    
    lazy var backgroundFistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "STN-Logo-white")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
        
        backgroundFistImageView.anchor(superView: view, top: view.topAnchor,
                               padding: .init(top:32), size: .init(width: 110, height: 110))
        backgroundFistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        collectionView.anchor(superView: view, top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets.zero, size: CGSize.zero)
        
        setupDonationButton()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: emptyCellIdentifier)
        collectionView.register(DMDTitleCell.self, forCellWithReuseIdentifier: DMDTitleCell.reuseIdentifier)
        collectionView.register(DMDTextContentCell.self, forCellWithReuseIdentifier: DMDTextContentCell.reuseIdentifier)
        collectionView.register(DMDHashtagCell.self, forCellWithReuseIdentifier: DMDHashtagCell.reuseIdentifier)
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
    
    private func setupDonationButton() {
        donationButtonContainerView.setButtonPressed {
            // TODO: Donation button action
        }
        
        donationButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        donationButtonContainerView.backgroundColor = .white
        view.addSubview(donationButtonContainerView)
        donationButtonContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        donationButtonContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        donationButtonContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        donationButtonContainerView.heightAnchor.constraint(equalToConstant: 105).isActive = true
        
        collectionView.bottomAnchor.constraint(equalTo: donationButtonContainerView.topAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Button Action
    @objc func dismissAction(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func shareAction(_ sender: Any) {
        // TODO: Share button action
    }
    
}
