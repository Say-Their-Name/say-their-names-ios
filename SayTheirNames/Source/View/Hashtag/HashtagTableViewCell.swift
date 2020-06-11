//
//  PersonHashtagTableViewCell.swift
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

protocol HashtagCollectionViewCellDelegate: class {
    func didTapHashtag(_ hashtag: Hashtag)
}

class HashtagTableViewCell: UITableViewCell {
    
    private let hashtagSizeModel = HashtagSizingModel()
    weak var cellDelegate: HashtagCollectionViewCellDelegate?

    static var reuseIdentifier: String {
        return "\(Self.self)"
    }
    
    lazy var hashtagLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Person.hashtags.localizedUppercase
        label.textColor = UIColor(asset: STNAsset.Color.strongHeader)
        label.font = UIFont.STN.sectionHeader
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var hashtagCopyTipLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Person.hashtagCopyTip.localizedUppercase
        label.textColor = UIColor(asset: STNAsset.Color.strongHeader)
        label.font = UIFont.STN.bannerSubitle
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = Theme.Components.Padding.medium
        layout.estimatedItemSize = Theme.Screens.Home.Person.Hashtag.collectionviewItemSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = UIColor(asset: STNAsset.Color.background)
        collectionView.contentInset = .init(top: 0,
                                            left: Theme.Components.Padding.large,
                                            bottom: 0,
                                            right: Theme.Components.Padding.large)
        return collectionView
    }()
    
    private var collectionViewHeight: NSLayoutConstraint?
    private var cellHeight: NSLayoutConstraint?

    private var identifier: String = ""
    public var hashtags: [Hashtag] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         backgroundColor = UIColor(asset: STNAsset.Color.background)
         setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric,
                      height: self.calculatedCellHeight())
    }

    private func calculatedCellHeight() -> CGFloat {
        var height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        height += hashtagSizeModel.height(forWidth: self.frame.width)
        height += (Theme.Components.Padding.small * 2)
        height += (Theme.Components.Padding.large * 2)
        return height
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionViewHeight?.constant = hashtagSizeModel.height(forWidth: self.frame.size.width) + (Theme.Components.Padding.small * 2)
    }
    
    func configure(with hashtags: [Hashtag]) {
        self.hashtags = hashtags
        self.collectionView.reloadData()
    }
    
    private func setupLayout() {
        hashtagLabel.anchor(superView: self,
                            top: topAnchor,
                            leading: leadingAnchor,
                            trailing: trailingAnchor,
                            padding: .init(top: Theme.Components.Padding.big, left: Theme.Components.Padding.large))

        hashtagCopyTipLabel.anchor(superView: self,
                                   top: hashtagLabel.bottomAnchor,
                                   leading: leadingAnchor,
                                   trailing: trailingAnchor,
                                   padding: .init(left: Theme.Components.Padding.large),
                                   size: CGSize(width: 0, height: 20))
        
        collectionView.anchor(superView: self,
                              top: hashtagCopyTipLabel.bottomAnchor,
                              leading: leadingAnchor,
                              trailing: trailingAnchor,
                              padding: .init(top: Theme.Components.Padding.medium),
                              size: .init(width: 0, height: 0))
    
        collectionViewHeight = collectionView.heightAnchor.constraint(equalToConstant: hashtagSizeModel.height(forWidth: 0))
        collectionViewHeight?.isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Theme.Components.Padding.large).isActive = true
    }
    
    // MARK: - Methods
    public func registerCell(with cell: UICollectionViewCell.Type) {
        identifier = cell.reuseIdentifier
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: cell)
        collectionView.reloadData()
    }
    
}

extension HashtagTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hashtags.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Set the data for each cell (color and color name)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HashtagViewCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        let hashtag = hashtags[indexPath.row]
        cell.setupHashtag(hashtag)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hashtag = self.hashtags[indexPath.row]
        self.cellDelegate?.didTapHashtag(hashtag)
    }
}
