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
    case news([Person])
    case medias([Person])
    case hashtags
    
    var identifier: String {
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
            PersonPhotoTableViewCell.register(to: tableView, identifier: identifier)
        case .info:
            PersonInfoTableViewCell.register(to: tableView, identifier: identifier)
        case .story:
            PersonOverviewTableViewCell.register(to: tableView, identifier: identifier)
        case .outcome:
            PersonOverviewTableViewCell.register(to: tableView, identifier: identifier)
        case .news:
            PersonNewsTableViewCell.register(to: tableView, identifier: identifier)
        case .medias:
            PersonNewsTableViewCell.register(to: tableView, identifier: identifier)
        case .hashtags:
            PersonHashtagTableViewCell.register(to: tableView, identifier: identifier)
        }
    }
    
    static var allCases: [PersonCellType] {
        return [.photo, .info, .story, .outcome, .news([]), .medias([]), .hashtags]
    }
    
    static func == (lhs: PersonCellType, rhs: PersonCellType) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

class PersonController: BaseViewController {
    
    var person: Person!
    var tableView: UITableView = UITableView(frame: .zero)
    let donationButtonContainerView = ButtonContainerView(frame: .zero)
    
    // TODO: Once Theme.swift/etc. gets added to the project this should get moved there.
    let navigationBarTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.STN.navBarTitle
    ]
    
    var cellCollectionTypes: [PersonCellType] = {
        return [.photo, .info, .story, .outcome, .news([]), .medias([]), .hashtags]
    }()
    
    lazy var fistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "STN-Logo-white")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "personView"
        tableView.backgroundColor = .clear
        tableView.contentInset = .init(top: 16)
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .black
        setupNavigationBarItems()
        setupTableView()
        setupDonationButton()
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
    
    @objc func dismissAction(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func shareAction(_ sender: Any) {
        // TODO: Share button action
    }
    
    private func registerCells(to tableView: UITableView) {
        PersonCellType.allCases.forEach { $0.register(to: tableView) }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.insetsContentViewsToSafeArea = false
        fistImageView.anchor(superView: view, top: view.topAnchor, padding: .init(top:32), size: .init(width: 110, height: 110))
        fistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ])
        
        registerCells(to: tableView)
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
        
        // Now we can set the anchor for the UITableView
        tableView.bottomAnchor.constraint(equalTo: donationButtonContainerView.topAnchor, constant: 0).isActive = true
    }
}

extension PersonController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCollectionTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cellCollectionTypes[indexPath.row]
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
             storyCell.setupCell(title: "THEIR STORY", description: person.bio)
            return storyCell
        case .outcome:
            let overviewCell = cell as! PersonOverviewTableViewCell
            overviewCell.setupCell(title: "OUTCOME", description: person.context)
            return overviewCell
        case let .news(news):
            let newsCell = cell as! PersonNewsTableViewCell
            newsCell.cellDelegate = self
            newsCell.registerCell(with: PersonNewsCollectionViewCell.self, type: PersonNewsCellType.news)
            newsCell.updateCellWithNews(news)
            return cell
        case let .medias(news):
            let newsCell = cell as! PersonMediaTableViewCell
            newsCell.cellDelegate = self
            newsCell.registerCell(with: PersonMediaCollectionViewCell.self, type: PersonNewsCellType.medias)
            newsCell.updateCellWithNews(news)
            return cell
            
        case .hashtags:
            let hashtagsCell = cell as! PersonHashtagTableViewCell
            hashtagsCell.registerCell(with: PersonHashtagCollectionViewCell.self)
            return hashtagsCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = cellCollectionTypes[indexPath.row]
        switch cellType {
        case .photo: return 420
        case .info: return 140
        case .news: return 340
        case .medias: return 300
        case .hashtags: return 160
        case .story, .outcome: return UITableView.automaticDimension
        }
    }
}

extension PersonController: CollectionViewCellDelegate {
    
    func collectionView(collectionviewcell: UICollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell) {
        print("\(index) tapped")
    }
}
