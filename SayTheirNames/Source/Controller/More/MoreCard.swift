//
//  MoreCard.swift
//  SayTheirNames
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

final class MoreCard: UIView {
    
    private lazy var contentCard: UIView = {
        
        let label = UILabel()
        label.text = L10n.sayTheirNames.localizedUppercase
        label.textColor = STNAsset.Color.white.color
        label.font = UIFont.STN.bannerTitle
        label.adjustsFontSizeToFitWidth = true
        
        let hashTag = UILabel()
        hashTag.text = "#BLACKLIVESMATTER"
        hashTag.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        hashTag.textColor = STNAsset.Color.white.color
        hashTag.adjustsFontSizeToFitWidth = true
        hashTag.numberOfLines = Theme.Components.LineLimit.single
        
        let header = UIStackView(arrangedSubviews: [label, hashTag])
        header.axis = .vertical
        header.spacing = Theme.Components.Padding.tiny
        
        let twitterLogo = UIImageView(image: UIImage(asset: STNAsset.Image.twitterLogo))
        twitterLogo.heightAnchor.constraint(equalToConstant: Theme.Screens.About.card.logoHeight).isActive = true
        twitterLogo.widthAnchor.constraint(equalToConstant: Theme.Screens.About.card.logoWidth).isActive = true

        let followUsLabel = UILabel()
        followUsLabel.text = L10n.GetInvolved.Twitter.title
        followUsLabel.textColor = STNAsset.Color.white.color
        followUsLabel.adjustsFontSizeToFitWidth = true
       
        let footer = UIStackView(arrangedSubviews: [twitterLogo, followUsLabel])
        footer.alignment = .center
        footer.spacing = Theme.Components.Padding.tiny
        
        let vStack = UIStackView(arrangedSubviews: [header, footer])
        vStack.axis = .vertical
        vStack.alignment = .leading
        vStack.distribution = .equalSpacing
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = STNAsset.Color.cellBackground.color
        
        let padding = Theme.Components.Padding.medium
        
        vStack.anchor(superView: imageView, top: imageView.topAnchor, leading: imageView.leadingAnchor, bottom: imageView.bottomAnchor, trailing: imageView.trailingAnchor, padding: UIEdgeInsets(padding, padding, padding, padding))
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    /// Configures constraints for subviews
    private func setupSubviews() {
        addSubview(contentCard)
        contentCard.anchor(superView: self, top: topAnchor, leading: leadingAnchor,
        bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .zero)
    }
}
