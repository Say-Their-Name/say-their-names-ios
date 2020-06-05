//
//  DMDTitleCell.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/5/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class DMDTitleCell: UICollectionViewCell {
    // MARK: - Property
    static let reuseIdentifier = "donations-more-details-title-cell"
    
    // MARK: - View
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.STN.title
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Class Method
    private func configureSubview() {
        contentView.addSubview(titleLabel)
        
        titleLabel.fillSuperview(superView: contentView, padding: .zero)
    }
    
    // MARK: - Configure Cell
    func configure(for donation: Donation) {
        titleLabel.text = donation.title
    }
}
