//
//  PetitionDetailView.swift
//  Say Their Names
//
//  Created by Joseph A. Wardell on 6/4/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// Most of this implementation is here as a placeholder
final class PetitionDetailView: UIView {

    private(set) var petition: PresentedPetition?

    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.STN.bannerTitle
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let summaryLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.STN.bannerSubitle
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let imageView = UIImageView()
    let verifiedLabel = UILabel()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dismissButton)
        
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            summaryLabel,
            imageView,
            verifiedLabel
        ])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            
            dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dismissButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
        
        backgroundColor = .white
        
        updateUI()
    }
    
    func set(petition: PresentedPetition?) {
        self.petition = petition
        updateUI()
    }
    
    private func updateUI() {
        titleLabel.text = petition?.title ?? ""
        summaryLabel.text = petition?.summary ?? ""
        imageView.image = petition?.image
        verifiedLabel.text = petition?.isVerified == true ? "verified" : "not verified"
    }
}
