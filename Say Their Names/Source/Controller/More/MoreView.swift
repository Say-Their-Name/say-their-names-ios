//
//  MoreView.swift
//  Say Their Names
//
//  Created by Hakeem King on 6/4/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// The UI for More
final class MoreView: UIView {
    
    private lazy var moreLabel: UILabel = {
        let label = UILabel()
        label.text = "More"
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
        setupMoreLabel()
    }
}

// MARK: - Configurations

private extension MoreView {
    
    func setupMoreLabel() {
        addSubview(moreLabel)
        moreLabel.fillSuperview()
    }
    
}
