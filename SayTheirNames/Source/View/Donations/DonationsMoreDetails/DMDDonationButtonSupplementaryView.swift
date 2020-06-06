//
//  DMDDonationButtonSupplementaryView.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class DMDDonationButtonSupplementaryView: UICollectionReusableView {
    // MARK: - Property
    static let reuseIdentifier = "donations-more-details-button-view"
    private var buttonPressedAction: (() -> Void)?
    
    // MARK: - View
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Donate".uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.STN.sectionHeader
        button.backgroundColor = .black
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonDidPress(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        clipsToBounds = true
        button.fillSuperview(superView: self, padding: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Button Action
    @objc private func buttonDidPress(_ sender: Any) {
        buttonPressedAction?()
    }
    
    // MARK: - Method
    public func setButtonPressed(action: @escaping () -> Void) {
        buttonPressedAction = action
    }
}
