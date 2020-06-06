//
//  DMDSectionTitleSupplementaryView.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class DMDSectionTitleSupplementaryView: UICollectionReusableView {
    // MARK: - Property
    static let reuseIdentifier = "donations-more-details-title-view"
    
    // MARK: - View
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1)
        label.font = UIFont(name: "Karla-Bold", size: 19)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        clipsToBounds = true
        titleLabel.fillSuperview(superView: self, padding: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    public func setTitle(text: String) {
        titleLabel.text = text
    }
}
