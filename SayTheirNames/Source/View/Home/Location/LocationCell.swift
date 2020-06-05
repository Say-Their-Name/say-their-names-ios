//
//  LocationCell.swift
//  SayTheirNames
//
//  Created by Ahmad Karkouti on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class LocationCell: UICollectionViewCell {

    static let locationIdentifier = "locationCell"
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.STN.black : .clear
            titleLabel.textColor = isSelected ? UIColor.STN.white : UIColor.STN.black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.fillSuperview()
        layer.borderColor = UIColor.STN.black.cgColor
        layer.borderWidth = 1.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        styleLabels()
    }
    
    func configure(with location: Location) {
        titleLabel.text = location.name
    }

    private func styleLabels() {

        titleLabel.font = UIFont.STNDynamic.locationText
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            styleLabels()
        }
    }

}
