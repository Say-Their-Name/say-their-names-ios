//
//  PetitionDetailView.swift
//  Say Their Names
//
//  Copyright (c) 2020 Say Their Names Team (https://github.com/Say-Their-Name)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

// Most of this implementation is here as a placeholder
final class PetitionDetailView: UIView {

    private(set) var petition: PresentedPetition?

    let titleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let summaryLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.accessibilityIgnoresInvertColors = true
        return imageView
    }()
    
    let verifiedLabel = UILabel()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
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
            
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
        
        backgroundColor = UIColor(asset: STNAsset.Color.white)
        
        updateUI()
        
        styleLabels()
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
    
    private func styleLabels() {

        titleLabel.font = UIFont.STN.bannerTitle
        summaryLabel.font = UIFont.STN.bannerSubitle
        verifiedLabel.font = UIFont.STN.verifiedTag
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            styleLabels()
        }
    }

}
