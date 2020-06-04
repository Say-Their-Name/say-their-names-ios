//
//  SettingsView.swift
//  Say Their Names
//
//  Created by Hakeem King on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// The UI for Settings
final class SettingsView: UIView {
    
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textAlignment = .center
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
        setupSettingsLabel()
    }
}

// MARK: - Configurations

private extension SettingsView {
    
    func setupSettingsLabel() {
        addSubview(settingsLabel)
        settingsLabel.fillSuperview()
    }
    
}
