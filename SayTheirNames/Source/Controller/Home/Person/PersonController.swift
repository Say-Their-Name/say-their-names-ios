//
//  PersonController.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

enum PersonCellType: Equatable {
    case photo
    case info
    case story
    case outcome
    case news([Person])
    case medias([Person])
    
    var identifier: String {
        switch self {
        case .photo: return "PersonCellType_Photo"
        case .info: return "PersonCellType_Info"
        case .story: return "PersonCellType_Story"
        case .outcome: return "PersonCellType_Outcome"
        case .news: return "PersonCellType_News"
        case .medias: return "PersonCellType_Media"
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
        }
    }
    
    static var allCases: [PersonCellType] {
        return [.photo, .info, .story, .outcome, .news([]), .medias([])]
    }
    
    static func == (lhs: PersonCellType, rhs: PersonCellType) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

class PersonController: BaseViewController {
    
    var person: Person!
    
    var sareArea: UILayoutGuide!
    var tableView: UITableView = UITableView(frame: .zero)
    
    var cellCollectionTypes: [PersonCellType] = {
        return [.photo, .info, .story, .outcome, .news([]), .medias([])]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "personView"
    }
    
    override func loadView() {
        super.loadView()
        sareArea = view.layoutMarginsGuide
        setupNavigationBarItems()
        setupTableView()
    }
    
    private func setupNavigationBarItems() {
        
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
        // Present share bottom sheet view
    }
    
    private func registerCells(to tableView: UITableView) {
        PersonCellType.allCases.forEach { $0.register(to: tableView) }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: sareArea.topAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
        registerCells(to: tableView)
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
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = cellCollectionTypes[indexPath.row]
        switch cellType {
            case .photo:return 520
            case .info: return 140
            case .news: return 340
            case .medias: return 270
            case .story, .outcome: return UITableView.automaticDimension
        }
    }
}

extension PersonController: CollectionViewCellDelegate {
    
    func collectionView(collectionviewcell: UICollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell) {
        print("\(index) tapped")
    }
}
