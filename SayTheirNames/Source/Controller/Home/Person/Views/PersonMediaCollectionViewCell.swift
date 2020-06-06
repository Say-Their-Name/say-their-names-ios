//
//  PersonMediaCollectionViewCell.swift
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

class PersonMediaCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return "\(Self.self)"
    }
    
    lazy var mediaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "media-image-2")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    private func setupLayout() {
        mediaImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mediaImageView)
        contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            mediaImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            mediaImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mediaImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            mediaImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
}
