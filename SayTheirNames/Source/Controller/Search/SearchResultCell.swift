//
//  SearchResultCell.swift
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

class SearchResultCell: UITableViewCell {

    private lazy var imgView = UIImageView.create {
        $0.tintColor = STNAsset.Color.inverse.color
    }
    
    private lazy var titleLabel = UILabel.create {
        $0.font = UIFont.STN.searchResultTitle
    }
    
    private lazy var subtitleLabel = UILabel.create {
        $0.isHidden = true
    }
    
    private lazy var labelStackView = UIStackView.create {
        $0.axis = .vertical
    }
    
    private lazy var contentStackView = UIStackView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 24
    }
    
    private lazy var separatorView = UIView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = STNAsset.Color.separator.color
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupSubviews() {
        labelStackView.addArrangedSubviews(titleLabel, subtitleLabel)
        contentStackView.addArrangedSubviews(imgView, labelStackView)
        contentView.addSubview(contentStackView)
        contentView.addSubview(separatorView)
        
        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imgView.widthAnchor.constraint(equalToConstant: Self.imgViewDimension),
            imgView.heightAnchor.constraint(equalToConstant: Self.imgViewDimension),
            
            contentStackView.topAnchor.constraint(equalTo: guide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func populate(with searchResult: SearchResult) {
        imgView.image = searchResult.image
        titleLabel.text = searchResult.title.uppercased()
        subtitleLabel.text = searchResult.subtitle
        subtitleLabel.isHidden = searchResult.subtitle == nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        subtitleLabel.isHidden = true
    }
    
}

extension SearchResultCell {
    private static let imgViewDimension: CGFloat = 24
}
