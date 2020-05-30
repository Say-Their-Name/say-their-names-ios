//
//  CategoriesCell.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.karla(weight: .bold, size: 13)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.anchor(superView: self, top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
