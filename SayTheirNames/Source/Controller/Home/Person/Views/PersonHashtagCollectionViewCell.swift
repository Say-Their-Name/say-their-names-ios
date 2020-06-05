//
//  PersonHashtagCollectionViewCell.swift
//  SayTheirNames
//
//  Created by Franck-Stephane Ndame Mpouli on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonHashtagCollectionViewCell: UICollectionViewCell {
    lazy var hashtagLabel: UILabel = {
        let label = UILabel()
        label.text = "#JUSTICEFORFIRST"
        label.font = UIFont(name: "Karla-Bold", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.STN.black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        layer.borderWidth = 1.5
        hashtagLabel.fillSuperview(superView: self)
    }
}
