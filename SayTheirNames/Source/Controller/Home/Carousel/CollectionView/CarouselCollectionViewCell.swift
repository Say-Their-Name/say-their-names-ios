//
//  CarouselCollectionViewCell.swift
//  Say Their Names
//
//  Created by Thomas Murray on 06/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

protocol CollectionViewCellProtocol where Self: UICollectionViewCell {
    func setUp<T>(with data: T)
}

final class CarouselCollectionViewCell: UICollectionViewCell, CollectionViewCellProtocol {

    // MARK: - Properties
    private lazy var hStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .vertical
        hStack.spacing = 0
        hStack.distribution = .fillEqually
        return hStack
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        return imageView
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .left
        label.font = UIFont.STN.bannerTitle
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .left
        label.font = UIFont.STN.bannerSubitle
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Methods
    func setUp<T>(with data: T) {
        //cast the data to the correct data type for usage. Left as model type has not been created yet.
        //setup cell
        configureView()
        titleLabel.text = "#BLACKLIVESMATTER"
        descriptionLabel.text = data as? String ?? "How to get involved"
    }
    
    private func configureView() {
        imageView.fillSuperview(superView: self)
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(descriptionLabel)
        hStack.anchor(superView: self, leading: leadingAnchor, bottom: bottomAnchor,
                      trailing: trailingAnchor,padding: .init(left: 22, bottom: 22, right:22))
        
    }
}
