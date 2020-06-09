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
        $0.clipsToBounds = true
        
        // TODO: set proper placeholder
        $0.image = UIImage(asset: STNAsset.Image.mediaImage2)
    }
    
    private lazy var tagView = TagView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
    }
    
    private lazy var titleLabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(asset: STNAsset.Color.primaryLabel)
        $0.font = UIFont.STN.ctaTitle
        $0.numberOfLines = 2
    }
    
    private lazy var bodyLabel = UILabel.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(asset: STNAsset.Color.primaryLabel)
        $0.font = UIFont.STN.ctaBody
        $0.numberOfLines = 3
    }
    
    private lazy var actionButton = UIButton.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor(asset: STNAsset.Color.actionButton).cgColor
        $0.titleLabel?.font = UIFont.STN.sectionHeader
        $0.layer.borderWidth = Self.actionButtonBorderWidth
        $0.tintColor = UIColor(asset: STNAsset.Color.actionButton)
        $0.setTitleColor(UIColor(asset: STNAsset.Color.primaryLabel), for: .normal)
        $0.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
    
    private lazy var stackView = UIStackView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = Self.stackViewSpacing
        $0.distribution = .equalSpacing
    }
    
    private lazy var containerView = UIView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .tertiarySystemBackground
        $0.layer.borderWidth = Self.containerViewBorderWidth
        $0.layer.borderColor = UIColor(asset: STNAsset.Color.gray).cgColor
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
            titleLabel,
            bodyLabel,
            actionButton
        )
        containerView.addSubview(imageView)
        containerView.addSubview(stackView)
        contentView.addSubview(containerView)
        contentView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            tagView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            tagView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -Self.defaultPadding),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Self.imageViewHeight),
            actionButton.heightAnchor.constraint(equalToConstant: Self.actionButtonHeight),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Self.defaultPadding),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Self.defaultPadding),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Self.defaultPadding),
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
        cta.imagePath.flatMap { imageView.populate(withURL: $0) }
        tagView.isHidden = cta.tag == nil || cta.tag?.isEmpty == true
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
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.origin = .zero
        frame.size.height = ceil(size.height)
        // TODO: Need a better way of getting the width of the cell
        frame.size.width = ceil(UIScreen.main.bounds.width)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    private func updateCGColors() {
        actionButton.layer.borderColor = UIColor(asset: STNAsset.Color.actionButton).cgColor
        containerView.layer.borderColor = UIColor(asset: STNAsset.Color.gray).cgColor
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateCGColors()
        self.setNeedsDisplay()
    }
}

// TODO: Move this to the theming section
private extension CallToActionCell {
    static let actionButtonBorderWidth: CGFloat = 2
    static let actionButtonHeight: CGFloat = 50
    static let containerViewBorderWidth: CGFloat = 2
    static let defaultPadding: CGFloat = 16
    static let imageViewHeight: CGFloat = 125
    static let stackViewSpacing: CGFloat = 8
}
