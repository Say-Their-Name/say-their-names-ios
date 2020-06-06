//
//  PersonNewsTableViewCell.swift
//  Say Their Names
//
//  Created by Manase on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

struct CollectionViewCellModel {
    var person: Person
}

protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: UICollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

// Re-using `PersonNewsTableViewCell` to present media table view cell
typealias PersonMediaTableViewCell = PersonNewsTableViewCell

enum PersonNewsCellType: String {
    case news
    case medias
    
    var identifier: String {
        switch self {
        case .news: return PersonNewsCollectionViewCell.reuseIdentifier
        case .medias: return PersonMediaCollectionViewCell.reuseIdentifier
        }
    }
}

class PersonNewsTableViewCell: UITableViewCell {

    static var reuseIdentifier: String {
        return "\(Self.self)"
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NEWS"
        label.textColor = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1)
        label.font = UIFont(name: "Karla-Bold", size: 17)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() 
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 1.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(left: 32,right: 32)
        return collectionView
    }()
    
    weak var cellDelegate: CollectionViewCellDelegate?
    var news: [Person]?
    
    private var cellType: PersonNewsCellType = PersonNewsCellType.news
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         backgroundColor = .white
         setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        titleLabel.anchor(superView: contentView,
                          top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          trailing: contentView.trailingAnchor,
                          padding: .init(top: 40, left: 32, right: 32))
        
        collectionView.anchor(superView: contentView,
                              top: titleLabel.bottomAnchor,
                              leading: contentView.leadingAnchor,
                              bottom: contentView.bottomAnchor,
                              trailing: contentView.trailingAnchor,
                              padding: .init(top: 20, left: 0, right: 0))
    }
    
    // Updates current cell content views
    private func updateCellViews() {
        let titleText = (cellType == PersonNewsCellType.medias) ? L10n.Person.media : L10n.Person.news
        titleLabel.text = titleText.uppercased()
    }
    
    // Registers collection view cells and update current cell content views
    public func registerCell(with cell: UICollectionViewCell.Type, type: PersonNewsCellType) {
        cellType = type
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: cell)
        updateCellViews()
    }
    
}

extension PersonNewsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // The data we passed from the TableView send them to the CollectionView Model
    func updateCellWithNews(_ news: [Person]) {
        self.news = news
        self.collectionView.reloadData()
    }
    
    func updateCellWithMedias(_ news: [Person]) {
        self.news = news
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: collectionView.bounds.height)
    }
    
    // Add spaces at the beginning and the end of the collection view
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
}
