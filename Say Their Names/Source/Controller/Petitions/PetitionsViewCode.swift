//
//  PetitionsUI.swift
//  Say Their Names
//
//  Created by Kyle Lee on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// The UI for Petitions
final class PetitionsViewCode: UIView {
    
    private lazy var petitionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Petitions"
        label.textAlignment = .center
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupSubviews()
    }
    
    /// Configures properties for the view itself
    private func setupSelf() {
        backgroundColor = .systemBackground
    }
    
    /// Adds and configures constraints for subviews
    private func setupSubviews() {
        setupPetitionsLabel()
    }
}

// MARK: - Configurations

private extension PetitionsViewCode {
    
    func setupPetitionsLabel() {
        addSubview(petitionsLabel)
        
        petitionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            petitionsLabel.topAnchor.constraint(equalTo: topAnchor),
            petitionsLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            petitionsLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            petitionsLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
}
