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
        let logo = UIImageView(image: UIImage(asset: STNImage.stnLogoWhite))
        
        let label = UILabel()
        label.text = "SAY THEIR NAME"
        label.textColor = UIColor.STN.white
        label.font = UIFont.STN.bannerTitle
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let header = UIStackView(arrangedSubviews: [logo, label])
        header.axis = .horizontal
        header.alignment = .center
        header.spacing = 8
        header.translatesAutoresizingMaskIntoConstraints = false
        
        let hashTag = UILabel()
        hashTag.text = "#BLACKLIVESMATTER"
        hashTag.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        hashTag.textColor = .white
        hashTag.adjustsFontSizeToFitWidth = true
        hashTag.numberOfLines = Theme.Components.LineLimit.single
        hashTag.translatesAutoresizingMaskIntoConstraints = false
        
        let vStack = UIStackView(arrangedSubviews: [header, hashTag])
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.spacing = 10
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            logo.heightAnchor.constraint(equalToConstant: 30),
            logo.widthAnchor.constraint(equalToConstant: 20)
        ])
        
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
