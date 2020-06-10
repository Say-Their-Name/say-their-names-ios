//
//  PersonNewsTableViewCell.swift
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

struct CollectionViewCellModel {
    var person: Person
}

protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: UICollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell)
    // other delegate methods that you can define to perform action in viewcontroller
}

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
        label.textColor = UIColor(asset: STNAsset.Color.strongHeader)
        label.font = UIFont.STN.sectionHeader
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
        collectionView.backgroundColor = UIColor(asset: STNAsset.Color.background)
        collectionView.contentInset = .init(left: Theme.Components.Padding.large,right: Theme.Components.Padding.large)
        return collectionView
    }()
    
    weak var cellDelegate: CollectionViewCellDelegate?
    var medias: [Media] = []
    var news: [News] = []
    
    private var cellType: PersonNewsCellType = PersonNewsCellType.news
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         backgroundColor = UIColor(asset: STNAsset.Color.background)
         setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var preferredContentHeight: CGFloat { Theme.Screens.Home.Person.News.contentHeigh }

    private func setupLayout() {
        titleLabel.anchor(superView: contentView,
                          top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          trailing: contentView.trailingAnchor,
                          padding: .init(top: Theme.Components.Padding.extraLarge,
                                         left: Theme.Components.Padding.large,
                                         right: Theme.Components.Padding.large))
        
        collectionView.anchor(superView: contentView,
                              top: titleLabel.bottomAnchor,
                              leading: contentView.leadingAnchor,
                              bottom: contentView.bottomAnchor,
                              trailing: contentView.trailingAnchor,
                              padding: .init(top: Theme.Components.Padding.medium))
 
        collectionView.heightAnchor.constraint(equalToConstant: preferredContentHeight).isActive = true
    }
    
    // Updates current cell content views
    private func updateCellViews() {
        let titleText = (cellType == PersonNewsCellType.medias) ? L10n.Person.media : L10n.Person.news
        titleLabel.text = titleText.localizedUppercase
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
    func updateCellWithNews(_ news: [News]) {
        self.news = news
        self.collectionView.reloadData()
    }
    
    func updateCellWithMedias(_ medias: [Media]) {
        self.medias = medias
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType {
        case .news:
            return news.count
        case .medias:
            return medias.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath)
        switch cellType {
        case .news:
            // UPDATE cell
            return cell
        case .medias:
            let mediaCell = cell as! PersonMediaCollectionViewCell
            let mediaUrl = medias[indexPath.row].imageUrl
            mediaCell.updateCell(with: mediaUrl)
            return mediaCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Theme.Screens.Home.Person.News.collectionViewWidth,
                      height: collectionView.bounds.height)
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

// the only difference between PersonMediaTableViewCell and PersonNewsTableViewCell is the preferred height of their collectionview
class PersonMediaTableViewCell: PersonNewsTableViewCell {
    
    override var preferredContentHeight: CGFloat { Theme.Screens.Home.Person.Media.contentHeigh }

}
