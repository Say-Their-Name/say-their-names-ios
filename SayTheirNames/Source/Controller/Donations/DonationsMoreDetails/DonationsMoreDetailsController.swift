//
//  DonationsMoreDetailsController.swift
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

protocol CommunitySupportEntity {
    var id: Int { get }
    var identifier: String { get }
    var title: String { get }
    var description: String { get }
    var type: DonationType? { get }
    var outcome: String { get }
    var link: String { get }
    var outcomeImagePath: String { get }
    var person: Person? { get }
    var bannerImagePath: String { get }
    var shareable: Shareable { get }
    var hashtags: [Hashtag] { get }
}

extension Donation: CommunitySupportEntity {
}

extension Petition: CommunitySupportEntity {
}

final class DonationsMoreDetailsController: UIViewController {

    enum Data {
        case donation(Donation)
        case petition(Petition)
        
        var entity: CommunitySupportEntity {
            switch self {
            case .donation(let donation):
                return donation
            case .petition(let petition):
                return petition
            }
        }
    }
    
    @DependencyInject private var network: NetworkRequestor
    @DependencyInject private var shareService: ShareService

    // MARK: - Section Layout Kind
    enum DonationSectionLayoutKind: Int, CaseIterable {
        case title = 0
        case description = 1
        case outcome = 2
        case socialMedia = 3
    }
    
    // MARK: - Accessibility Identifiers
    private enum AccessibilityIdentifers {
        static let view = "donationsMoreDetails"
        static let shareButton = "shareButton"
        static let dimissButton = "dismissButton"
        static let donationButtonContainerView = "donationButtonContainerView"
    }
    
    // MARK: - Supplementary View Kind
    static let photoSupplementaryView = "photo"
    static let sectionTitleSupplementaryView = "sectionTitle"
    
    // MARK: - Property
    var data: Data!
    
    internal let emptyKind = "empty-kind"
    internal let emptyCellIdentifier = "empty-cell-identifier"
    internal let emptyViewIdentifier = "empty-view-identifier"
    
    private let navigationBarTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor(asset: STNAsset.Color.navBarForeground),
        NSAttributedString.Key.font: UIFont.STN.navBarTitle
    ]

    // MARK: - Initialization
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: Self.donationMoreDetailsCVLayout)
        collectionView.backgroundColor = UIColor(asset: STNAsset.Color.background)
        return collectionView
    }()
    
    private let donationButtonContainerView = ButtonContainerView(frame: .zero)
    
    lazy var backgroundFistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(asset: STNAsset.Image.stnLogoWhite)
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
        collectionView.delegate = self

        view.accessibilityIdentifier = AccessibilityIdentifers.view
        donationButtonContainerView.accessibilityIdentifier = AccessibilityIdentifers.donationButtonContainerView
             
        switch data! {
            
        case .petition(let petition):
            self.network.fetchPetitionDetails(with: petition.identifier) { [weak self] (result) in
                switch result {
                case .success(let page):
                    self?.configure(with: Data.petition(page.petition))
                    
                case .failure(let error):
                    Log.print(error)
                }
            }
            
        case .donation(let donation):
            
            self.network.fetchDonationDetails(with: donation.identifier) { [weak self] (result) in
                switch result {
                case .success(let page):
                    self?.configure(with: Data.donation(page.donation))
                    
                case .failure(let error):
                    Log.print(error)
                }
            }
        }
    }
    
    private func configure(with data: Data) {
        self.data = data
        self.collectionView.reloadData()
    }
    
    // MARK: - Class Method
    private func configureSubview() {
        view.backgroundColor = UIColor(asset: STNAsset.Color.background)
        
        backgroundFistImageView.anchor(superView: view, top: view.topAnchor,
                               padding: .init(top:32), size: .init(width: 110, height: 110))
        backgroundFistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        collectionView.anchor(superView: view,
                              top: view.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: nil,
                              trailing: view.trailingAnchor,
                              padding: UIEdgeInsets.zero,
                              size: CGSize.zero)
        
        setupDonationButton()
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: emptyCellIdentifier)
        collectionView.register(DMDTitleCell.self, forCellWithReuseIdentifier: DMDTitleCell.reuseIdentifier)
        collectionView.register(DMDTextContentCell.self, forCellWithReuseIdentifier: DMDTextContentCell.reuseIdentifier)
        collectionView.register(HashtagViewCollectionViewCell.self, forCellWithReuseIdentifier: HashtagViewCollectionViewCell.reuseIdentifier)
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: emptyKind,
                                withReuseIdentifier: emptyViewIdentifier)
        collectionView.register(DMDPhotoSupplementaryView.self,
                                forSupplementaryViewOfKind: DonationsMoreDetailsController.photoSupplementaryView,
                                withReuseIdentifier: DMDPhotoSupplementaryView.reuseIdentifier)
        collectionView.register(DMDSectionTitleSupplementaryView.self,
                                forSupplementaryViewOfKind: DonationsMoreDetailsController.sectionTitleSupplementaryView,
                                withReuseIdentifier: DMDSectionTitleSupplementaryView.reuseIdentifier)
    }
    
    private func setupNavigationBarItems() {
        // TODO: Once Theme.swift/etc gets added this may not be required
        navigationController?.navigationBar.titleTextAttributes = self.navigationBarTextAttributes as [NSAttributedString.Key: Any]
        
        self.title = L10n.sayTheirNames.localizedUppercase
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(asset: STNAsset.Color.navBarForeground) ?? .white,
         NSAttributedString.Key.font: UIFont(name: "Karla-Regular", size: 19) ?? UIFont.systemFont(ofSize: 17)]

        let dismissButton = UIButton(type: .system)
        dismissButton.setImage(UIImage(asset: STNAsset.Image.close)?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismissButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        dismissButton.addTarget(self, action: #selector(dismissAction(_:)), for: .touchUpInside)
        dismissButton.isAccessibilityElement = true
        dismissButton.accessibilityIdentifier = AccessibilityIdentifers.dimissButton
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dismissButton)
        
        let shareButton = UIButton(type: .system)
        shareButton.setImage(UIImage(asset: STNAsset.Image.shareWhite)?.withRenderingMode(.alwaysOriginal), for: .normal)
        shareButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        shareButton.addTarget(self, action: #selector(shareAction(_:)), for: .touchUpInside)
        shareButton.isAccessibilityElement = true
        shareButton.accessibilityIdentifier = AccessibilityIdentifers.shareButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = STNAsset.Color.navBarBackground.color
    }
    
    private func setupDonationButton() {
        donationButtonContainerView.setButtonPressed { [weak self] in
            guard let self = self else { return }
            guard let donationURL = URL(string: self.data.entity.link) else {
                       assertionFailure("Invalid donationURL")
                       return
                   }
            UIApplication.shared.open(donationURL)
        }
        

        switch data! {
        case .donation:
            donationButtonContainerView.setButtonTitle(L10n.donateNow)
        case .petition:
            donationButtonContainerView.setButtonTitle("Sign") // TODO: localize
        }

        donationButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        donationButtonContainerView.backgroundColor = UIColor(asset: STNAsset.Color.background)
        view.addSubview(donationButtonContainerView)
        donationButtonContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        donationButtonContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        donationButtonContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        donationButtonContainerView.heightAnchor.constraint(equalToConstant: 105).isActive = true
        
        collectionView.bottomAnchor.constraint(equalTo: donationButtonContainerView.topAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Button Action
    @objc private func dismissAction(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func shareAction(_ sender: Any) {
        self.present(self.shareService.share(items: [self.data.entity.shareable]), animated: true)
    }
}

// MARK: UICollectionViewDelegate

extension DonationsMoreDetailsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == DonationSectionLayoutKind.socialMedia.rawValue {
            let hashtag = data.entity.hashtags[indexPath.row]
            
            if let url = URL(string: hashtag.link) {
                UIApplication.shared.open(url)
            }
        }
    }
}
