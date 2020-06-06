//
//  PersonHashtagCollectionViewCell.swift
//  SayTheirNames
//
//  Created by Franck-Stephane Ndame Mpouli on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonHashtagCollectionViewCell: UICollectionViewCell {
    let hashtagView = HashtagView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        hashtagView.fillSuperview(superView: self)
    }
}
