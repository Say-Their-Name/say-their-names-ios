//
//  CarouselCollectionViewCell.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
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

final class CarouselCollectionViewCell: UICollectionViewCell {

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
        imageView.backgroundColor = UIColor(asset: STNAsset.Color.cellBackground)//.black
        return imageView
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .left
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textColor = UIColor(asset: STNAsset.Color.white)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(asset: STNAsset.Color.white)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Methods
    func configure(with data: HeaderCellContent) {
        //cast the data to the correct data type for usage. Left as model type has not been created yet.
        //setup cell
        configureView()
        configureText(data: data)
    }

    private func configureText(data: HeaderCellContent) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.imageView.image = nil
    }
}
