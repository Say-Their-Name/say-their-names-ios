//
//  CallToActionCell.swift
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

final class CallToActionCell: UICollectionViewCell {
    
    var executeAction: (() -> Void)?
    
    private lazy var imageView = UIImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        
        // TODO: remove dummy data
        $0.image = UIImage(named: "media-image-1")
    }
    
    private lazy var tagView = TagView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        
        // TODO: remove dummy data
        $0.setTitle(to: "VERIFIED")
    }
    
    private lazy var titleLabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor.STN.primaryLabel
        $0.font = UIFont.STN.ctaTitle
        $0.numberOfLines = 2
        
        // TODO: remove dummy data
        $0.text = "Black Lives Matter Resources"
    }
    
    private lazy var bodyLabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor.STN.primaryLabel
        $0.font = UIFont.STN.ctaBody
        $0.numberOfLines = 3
        
        // TODO: remove dummy data
        $0.text = "Following the tragic news surrounding the murder of George Floyd by Minneapolis police officers..."
    }
    
    private lazy var actionButton = UIButton.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor.STN.actionButton.cgColor
        $0.titleLabel?.font = UIFont.STN.sectionHeader
        $0.layer.borderWidth = Self.actionButtonBorderWidth
        $0.tintColor = UIColor.STN.actionButton
        $0.setTitleColor(UIColor.STN.primaryLabel, for: .normal)
        $0.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
    
    private lazy var stackView = UIStackView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = Self.stackViewSpacing
    }
    
    private lazy var containerView = UIView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .secondarySystemBackground
        $0.layer.borderWidth = Self.containerViewBorderWidth
        $0.layer.borderColor = UIColor.STN.gray.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupSubviews() {
        imageView.addSubview(tagView)
        stackView.addArrangedSubviews(
            imageView,
            titleLabel,
            bodyLabel,
            actionButton
        )
        containerView.addSubview(stackView)
        contentView.addSubview(containerView)
        
        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            tagView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            tagView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -Self.defaultPadding),
            
            imageView.heightAnchor.constraint(equalToConstant: Self.imageViewHeight),
            
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Self.defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -Self.defaultPadding),
            
            bodyLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Self.defaultPadding),
            bodyLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -Self.defaultPadding),
            
            actionButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Self.defaultPadding),
            actionButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -Self.defaultPadding),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Self.defaultPadding),
        
            containerView.topAnchor.constraint(equalTo: guide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
    func configure(with cta: CallToAction) {
        actionButton.setTitle(cta.actionTitle, for: .normal)
        bodyLabel.text = cta.body
        imageView.image = cta.image
        cta.tag.flatMap { tagView.setTitle(to: $0) }
        titleLabel.text = cta.title
    }
    
    @objc
    private func didTapActionButton() {
        executeAction?()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        actionButton.setTitle(nil, for: .normal)
        bodyLabel.text = nil
        imageView.image = nil
        tagView.prepareForReuse()
        titleLabel.text = nil
    }
}

private extension CallToActionCell {
    static let actionButtonBorderWidth: CGFloat = 2
    static let containerViewBorderWidth: CGFloat = 2
    static let defaultPadding: CGFloat = 16
    static let imageViewHeight: CGFloat = 125
    static let stackViewSpacing: CGFloat = 8
}