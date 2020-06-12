//
//  HeroTextCell.swift
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

final class HeroTextCell: UICollectionViewCell {
    
    private let title: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Karla-Bold", size: 21)
        return label
    }()
    
    private let body: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Regular", size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    func configure(with data: HeroContent) {
        configureView()
        configureText(data)
    }
    
    fileprivate func configureText(_ data: HeroContent) {
        title.text = data.title
        body.text = data.body
    }
    
    fileprivate func configureView() {
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        title.anchor(
            superView: self, top: topAnchor, leading: leadingAnchor,
            padding: .init(top: 24, left: 16))
        body.anchor(
            superView: self, top: title.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,
            padding: .init(top: 8, left: 16, right: 32))
    }
    
}