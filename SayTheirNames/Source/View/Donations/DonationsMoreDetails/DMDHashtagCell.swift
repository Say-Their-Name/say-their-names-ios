//
//  DMDHashtagCell.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class DMDHashtagCell: UICollectionViewCell {
    // MARK: - Property
    static let reuseIdentifier = "donations-more-details-hashtag-cell"
    
    // MARK: - View
    let hashtagView = HashtagView(frame: .zero)
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Cell
    private func configureCell() {
        hashtagView.fillSuperview(superView: self)
    }
}
