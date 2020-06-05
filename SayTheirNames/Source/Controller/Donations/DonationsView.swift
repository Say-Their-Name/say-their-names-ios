//
//  DonationsViewCode.swift
//  SayTheirNames
//
//  Created by Hakeem King on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// The UI for Donations
final class DonationsView: UIView {
    
    private lazy var donationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Donations"
        label.textAlignment = .center
        label.font = UIFont.STN.body
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    /// Configures properties for the view itself
    private func setupSelf() {
        backgroundColor = .systemBackground
        setupSubviews()
    }
    
    /// Adds and configures constraints for subviews
    private func setupSubviews() {
        setupDonationsLabel()
    }
}

// MARK: - Configurations

private extension DonationsView {
    
    func setupDonationsLabel() {
        addSubview(donationsLabel)
        donationsLabel.fillSuperview()
    }
    
}
