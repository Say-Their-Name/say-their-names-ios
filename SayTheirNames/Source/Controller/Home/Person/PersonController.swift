//
//  PersonController.swift
//  Say Their Names
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

enum PersonCellType: Equatable {
    case photo
    case info
    case story
    case outcome
    case news
    case medias
    case hashtags
    
    var identifier: String {
        switch self {
        case .photo: return PersonPhotoTableViewCell.reuseIdentifier
        case .info: return PersonInfoTableViewCell.reuseIdentifier
        case .story: return PersonOverviewTableViewCell.reuseIdentifier
        case .outcome: return PersonOverviewTableViewCell.reuseIdentifier
        case .news: return PersonNewsTableViewCell.reuseIdentifier
        case .medias: return PersonMediaTableViewCell.reuseIdentifier
        case .hashtags: return HashtagTableViewCell.reuseIdentifier
        }
    }
    
    var accessibilityIdentifier: String {
        switch self {
        case .photo: return "PersonCellType_Photo"
        case .info: return "PersonCellType_Info"
        case .story: return "PersonCellType_Story"
        case .outcome: return "PersonCellType_Outcome"
        case .news: return "PersonCellType_News"
        case .medias: return "PersonCellType_Media"
        case .hashtags: return "PersonCellType_Hashtags"
        }
    }
    
    func register(to tableView: UITableView) {
        switch self {
        case .photo:
            tableView.register(cellType: PersonPhotoTableViewCell.self)
        case .info:
            tableView.register(cellType: PersonInfoTableViewCell.self)
        case .story:
            tableView.register(cellType: PersonOverviewTableViewCell.self)
        case .outcome:
            tableView.register(cellType: PersonOverviewTableViewCell.self)
        case .news:
            tableView.register(cellType: PersonNewsTableViewCell.self)
        case .medias:
            tableView.register(cellType: PersonMediaTableViewCell.self)
        case .hashtags:
            tableView.register(cellType: HashtagTableViewCell.self)
        }
    }
    
    static var allCases: [PersonCellType] {
        return [.photo, .info, .story, .outcome, .news, .medias, .hashtags]
    }
}

// Alias for donation container view
typealias DontainButtonContainerView = ButtonContainerView

class PersonController: UIViewController {
    
    @DependencyInject private var network: NetworkRequestor
    @DependencyInject private var metadata: MetadataService
    @DependencyInject private var shareService: ShareService

    public var person: Person!
    private var isLoading = true
        
    private let donationButtonContainerView = DontainButtonContainerView(frame: .zero)
    private let tableViewCells: [PersonCellType] = {
        return [.photo, .info, .story, .news, .medias, .hashtags]
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.insetsContentViewsToSafeArea = false
        return tableView
    }()
    
    lazy var backgroundFistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(asset: STNAsset.Image.stnLogoWhite)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var dismissButton: UIButton = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissAction(_:)))
        let button = UIButton(type: .system)
        button.setImage(UIImage(asset: STNAsset.Image.close)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: Theme.Components.Button.Size.small.width,
                              height: Theme.Components.Button.Size.small.height)
        button.addGestureRecognizer(gesture)
        button.accessibilityLabel = L10n.close
        return button
    }()

    lazy var shareButton: UIButton = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(shareAction(_:)))
        let button = UIButton(type: .system)
        button.setImage(UIImage(asset: STNAsset.Image.shareWhite)?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: Theme.Components.Button.Size.small.width,
                              height: Theme.Components.Button.Size.small.height)
        button.addGestureRecognizer(gesture)
        button.accessibilityLabel = L10n.share
        return button
    }()
    
    // TODO: Once Theme.swift/etc. gets added to the project this should get moved there.
    let navigationBarTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.STN.navBarTitle
    ]
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "personView"
        self.network.fetchPersonDetails(with: person.identifier) { [weak self] result in
            switch result {
            case .success(let response):
                self?.configure(with: response.person)
            case .failure(let error):
                Log.print(error)
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        setupNavigationBarItems()
        setupSubViews()
    }
    
    @objc func dismissAction(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func shareAction(_ sender: Any) {
        self.present(self.shareService.share(items: [self.person.shareable]), animated: true)
    }
    
    private func registerCells(to tableView: UITableView) {
        PersonCellType.allCases.forEach { $0.register(to: tableView) }
    }
    
    // TODO: Update UITableView sections based on what info we have
    private func configure(with person: Person) {
        self.person = person
        
        // Warm up the MetadataService cache
        let urls = self.person.news.compactMap { URL(string: $0.url) }
        self.metadata.preheat(with: urls)
                
        tableView.reloadData()
    }
}

// MARK: - UIView Setup Methods
private extension PersonController {
    
    func setupNavigationBarItems() {
        title = L10n.Person.sayTheirNames.localizedUppercase
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dismissButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
    }
    
    func setupSubViews() {
        backgroundFistImageView.anchor(superView: view, top: view.topAnchor,
                                       padding: .init(top:Theme.Components.Padding.large), size: Theme.Screens.Home.Person.backgroundFistSize)
        backgroundFistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setupTableView()
        setupDonationBottomView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.anchor(superView: view, top: view.topAnchor, leading: view.leadingAnchor,
                         bottom: nil, trailing: view.trailingAnchor,
                         padding: .zero, size: .zero)
        
        registerCells(to: tableView)
    }
    
    func setupDonationBottomView() {
        donationButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        donationButtonContainerView.anchor(superView: view, top: nil, leading: view.leadingAnchor,
                                           bottom: view.bottomAnchor, trailing: view.trailingAnchor,
                                           padding: .zero,
                                           size: CGSize(width: view.bounds.width, height: Theme.Screens.Home.Person.donationViewHeight))
        
        tableView.anchor(superView: nil, top: nil, leading: nil,
                         bottom: donationButtonContainerView.topAnchor, trailing: nil,
                         padding: .zero, size: .zero)
        
        donationButtonContainerView.setButtonPressed { [weak self]
            in
            guard let self = self else { return }

            var donation = self.person.donations.first
            let donationsDetailsVC = DonationsMoreDetailsController()
            donationsDetailsVC.donation = donation
            
            self.navigationController?.pushViewController(donationsDetailsVC, animated: true)
        }
    }
}

// MARK: - UITableViewDelegate Methods
extension PersonController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource Methods
extension PersonController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = tableViewCells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        
        switch cellType {
        case .photo:
            let photoCell = cell as! PersonPhotoTableViewCell
            photoCell.setupCell(person)
            return photoCell
        case .info:
            let infoCell = cell as! PersonInfoTableViewCell
            infoCell.setupCell(person)
            return infoCell
        case .story:
            let storyCell = cell as! PersonOverviewTableViewCell
            storyCell.setupCell(title: L10n.Person.theirStory, description: person.story)
            return storyCell
        case .outcome:
            let overviewCell = cell as! PersonOverviewTableViewCell
            overviewCell.setupCell(title: L10n.Person.outcome, description: person.outcome)
            return overviewCell
        case .news:
            let newsCell = cell as! PersonNewsTableViewCell
            newsCell.cellDelegate = self
            newsCell.registerCell(with: PersonNewsCollectionViewCell.self, type: PersonNewsCellType.news)
            newsCell.updateCellWithNews(person.news)
            return cell
        case .medias:
            let newsCell = cell as! PersonMediaTableViewCell
            newsCell.cellDelegate = self
            newsCell.registerCell(with: PersonMediaCollectionViewCell.self, type: PersonNewsCellType.medias)
            newsCell.updateCellWithMedias(person.medias)
            return cell
        case .hashtags:
            let hashtagsCell = cell as! HashtagTableViewCell
            hashtagsCell.cellDelegate = self
            hashtagsCell.configure(with: person.hashtags)
            hashtagsCell.registerCell(with: HashtagViewCollectionViewCell.self)
            return hashtagsCell
        }
    }
}

// MARK: PersonCollectionViewCellDelegate

extension PersonController: PersonCollectionViewCellDelegate {
    
    func didTapNewsItem(_ news: News) {
        if let url = URL(string: news.url) {
            UIApplication.shared.open(url)
        }
    }
    
    func didTapMediaItem(_ media: Media) {
        print("Did tap media")
    }
}

// MARK: HashtagCollectionViewCellDelegate

extension PersonController: HashtagCollectionViewCellDelegate {
    
    func didTapHashtag(_ hashtag: Hashtag) {
        if let url = URL(string: hashtag.link) {
            UIApplication.shared.open(url)
        }
    }
}
