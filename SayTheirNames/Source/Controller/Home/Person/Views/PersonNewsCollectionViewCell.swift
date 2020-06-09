//
//  PersonNewsCollectionViewCell.swift
//  Say Their Names
//
//  Created by Manase on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonNewsCollectionViewCell: UICollectionViewCell {
 
    static var reuseIdentifier: String {
        return "\(Self.self)"
    }
    
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(asset: STNAsset.Image.mediaImage1)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var sourceContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(asset: STNAsset.Color.yellow)
        view.clipsToBounds = true
        view.addSubview(sourceImageView)
        return view
    }()
    
    lazy var sourceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(asset: STNAsset.Image.newsBbc)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var sourceInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Live updates: Another night of fire and fury as.."
        label.numberOfLines = 3
        label.font = UIFont.STN.sectionHeader
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor(asset: STNAsset.Color.detailLabel)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(asset: STNAsset.Color.background)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        sourceContainer.translatesAutoresizingMaskIntoConstraints = false
        sourceImageView.translatesAutoresizingMaskIntoConstraints = false
        sourceInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(sourceContainer)
        contentView.addSubview(sourceInfoLabel)
        
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            newsImageView.heightAnchor.constraint(equalToConstant: 165),
            
            sourceContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            sourceContainer.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 0),
            sourceContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            sourceContainer.heightAnchor.constraint(equalToConstant: 30),
            
            sourceImageView.leadingAnchor.constraint(equalTo: sourceContainer.leadingAnchor, constant: 0),
            sourceImageView.topAnchor.constraint(equalTo: sourceContainer.topAnchor, constant: 0),
            sourceImageView.trailingAnchor.constraint(equalTo: sourceContainer.trailingAnchor, constant: 0),
            sourceImageView.bottomAnchor.constraint(equalTo: sourceContainer.bottomAnchor, constant: 0),
            
            sourceInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            sourceInfoLabel.topAnchor.constraint(equalTo: sourceContainer.bottomAnchor, constant: 5),
            sourceInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            sourceInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
}
