//
//  CarouselCollectionViewCell.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

protocol CollectionViewCellProtocol where Self: UICollectionViewCell {
    var reuseID: String {get}
    func setUp(with data: Any)
}

extension CollectionViewCellProtocol {

    var reuseID: String {
        self.reuseIdentifier ?? ""
    }
}

class CarouselCollectionViewCell: UICollectionViewCell, CollectionViewCellProtocol {

    // MARK: - Properties
    override var reuseIdentifier: String? {
        return "CarouselCollectionViewCell"
    }
    private lazy var hStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .vertical
        hStack.spacing = 4
        hStack.distribution = .fillEqually
        return hStack
    }()
    private lazy var imageView: UIImageView = UIImageView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()

    // MARK: - Methods
    func setUp(with data: Any) {
        //cast the data to the correct data type for usage. Left as model type has not been created yet.
        //setup cell
        configureView()
        configureText()
    }

    private func configureText() {
        titleLabel.carouselCellTitleLabel()
        descriptionLabel.carouselCellDescriptionLabel()
        titleLabel.text = "#BLACKLIVESMATTER"
        descriptionLabel.text = "How to get involved"
    }

    private func configureView() {
        add(imageView) {
            $0.anchor(top: topAnchor,
                      leading: leadingAnchor,
                      bottom: bottomAnchor,
                      trailing: trailingAnchor)
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .black
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

extension UILabel {

    func carouselCellTitleLabel() {
        self.contentMode = .left
        self.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        self.textColor = .white
        self.adjustsFontSizeToFitWidth = true
        self.numberOfLines = 1
    }

    func carouselCellDescriptionLabel() {
          self.contentMode = .left
          self.font = UIFont.systemFont(ofSize: 17, weight: .regular)
          self.textColor = .white
          self.adjustsFontSizeToFitWidth = true
          self.numberOfLines = 1
      }

}
