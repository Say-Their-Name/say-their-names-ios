//
//  LocationCell.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class LocationCell: UICollectionViewCell {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.STN.locationText
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .stn_locationCellBackground
                titleLabel.textColor = .stn_locationCellForegroundSelected
            } else {
                backgroundColor = .clear
                titleLabel.textColor = .stn_locationCellForegroundDeselected
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.fillSuperview()
        layer.borderColor = UIColor.stn_locationCellBorder.cgColor
        layer.borderWidth = 1.5
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            layer.borderColor = UIColor.stn_locationCellBorder.cgColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
