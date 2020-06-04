//
//  CarouselCollectionViewCell.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
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
        hStack.spacing = 4
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
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Methods
    func setUp<T>(with data: T) {
        //cast the data to the correct data type for usage. Left as model type has not been created yet.
        //setup cell
        configureView()
        configureText()
    }

    private func configureText() {
        titleLabel.text = "#BLACKLIVESMATTER"
        descriptionLabel.text = Strings.carouselDescription
    }

    private func configureView() {
        add(imageView) {
            $0.anchor(top: topAnchor,
                      leading: leadingAnchor,
                      bottom: bottomAnchor,
                      trailing: trailingAnchor)
        }
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(descriptionLabel)
        add(hStack) {
            $0.anchor(top: nil,
                      leading: leadingAnchor,
                      bottom: bottomAnchor,
                      trailing: trailingAnchor,
                      padding: .init(top: 0,
                                     left: 22,
                                     bottom: 16,
                                     right: 0))
        }
    }
}
