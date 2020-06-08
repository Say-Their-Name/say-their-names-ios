//
//  ButtonContainerView.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/5/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class ButtonContainerView: UIView {
    // MARK: - Property
    private var buttonPressedAction: (() -> Void)?
    
    // MARK: - View
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Donate".uppercased(), for: .normal)
        button.backgroundColor = UIColor.STN.actionButton
        button.tintColor = UIColor.STN.actionButtonTint
        button.addTarget(self, action: #selector(buttonDidPress(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Subview
    private func configureView() {
        self.backgroundColor = UIColor.STN.background

        // Separator
        let separator = UIView(frame: .zero)
        separator.backgroundColor = UIColor.STN.separator
        
        addSubview(separator)
        addSubview(button)
        
        // Layout Constraint
        separator.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: self.topAnchor),
            separator.leftAnchor.constraint(equalTo: self.leftAnchor),
            separator.rightAnchor.constraint(equalTo: self.rightAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            button.heightAnchor.constraint(equalToConstant: 50),
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32),
            button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32)
        ])
    }
    
    // MARK: - Button Action
    @objc private func buttonDidPress(_ sender: Any) {
        buttonPressedAction?()
    }
    
    // MARK: - Method
    public func setButtonPressed(action: @escaping () -> Void) {
        buttonPressedAction = action
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        styleControls()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            styleControls()
        }
    }

    private func styleControls() {

        button.titleLabel?.font = UIFont.STN.fullBleedButton
    }

}
