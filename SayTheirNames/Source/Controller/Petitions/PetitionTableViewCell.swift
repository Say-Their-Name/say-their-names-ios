//
//  PetitionTableViewCell.swift
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

final class PetitionTableViewCell: UITableViewCell {

    var findOutMoreAction : () -> Void = {}

    private lazy var container: UIView = {
       let container = UIView()
        container.backgroundColor = Self.ContainerBackgroundColor
        container.layer.borderColor = Self.ContainerOutlineColor.cgColor
        container.layer.borderWidth = Self.ContainerOutlineThickness
        return container
    }()
    
    private let bannerImageView: UIImageView = {
        let bannerImageView = UIImageView()
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.accessibilityIgnoresInvertColors = false
        return bannerImageView
    }()

    private lazy var imageViewContainer: UIView = {
        let imageViewContainer = UIView()
        imageViewContainer.clipsToBounds = true
        imageViewContainer.addSubview(bannerImageView)
        imageViewContainer.backgroundColor = Self.ContainerOutlineColor
        imageViewContainer.accessibilityIgnoresInvertColors = true
        return imageViewContainer
    }()
    
    private lazy var verifiedLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.verified
        label.font = UIFont.STN.verifiedTag
        label.backgroundColor = Self.VerifiedLabelBackgroundColor
        label.textColor = Self.VerifiedLabelTextColor
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.STN.bannerTitle
        label.textColor = Self.ContentColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.STN.summary
        label.textColor = Self.ContentColor
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private lazy var findOutMoreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(findOutMoreButtonTapped), for: .touchUpInside)
        
        button.setTitle(Strings.findOutMore.uppercased(), for: .normal)
        button.layer.borderColor = Self.ContentColor.cgColor
        button.titleLabel?.font = UIFont.STN.sectionHeader
        button.layer.borderWidth = Self.FindOutMoreButtonOutlineThickness
        button.tintColor = Self.ContentColor
        button.setTitleColor(Self.ContentColor, for: .normal)
        return button
    }()
        
    private var hasLayedOutSubviews = false
    private func createLayout() {
        guard !hasLayedOutSubviews else { return }
        hasLayedOutSubviews = true

        [container,
         imageViewContainer,
         bannerImageView,
         verifiedLabel,
         titleLabel,
         summaryLabel,
         findOutMoreButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(container)
        
        imageViewContainer.addSubview(verifiedLabel)
        
        [imageViewContainer,
         titleLabel,
         summaryLabel,
         findOutMoreButton,
         verifiedLabel].forEach {
            container.addSubview($0)
        }
        
        // the verified label should always appear visually above everything else
        verifiedLabel.layer.zPosition = 100
    }
    
    // ensure that updateConstraints is always called
    override class var requiresConstraintBasedLayout: Bool { true }
    
    private lazy var imageContainerHeight: NSLayoutConstraint = {
        imageViewContainer.heightAnchor.constraint(equalToConstant: nil == bannerImageView.image ? 0 : Self.PetitionImageHeight)
    }()
    
    private var haveBuiltConstraints = false
    override func updateConstraints() {
        super.updateConstraints()
                
        createLayout()
        
        imageContainerHeight.constant = nil == bannerImageView.image ? 0 : Self.PetitionImageHeight
        
        // NOTE: when changing from landscape to portrait, or vice versa,
        // this code DOES cause autolayout conflicts
        // but they are fixed in subsequent passes
        // in the same call stack and thus are never seen by the user
        
        guard !haveBuiltConstraints else { return }
        haveBuiltConstraints = true
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow - 1, for: .horizontal)
                        
        let constraints = [
            
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.ContainerHorizontalMargin),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.ContainerHorizontalMargin),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.ContainerVerticalMarrgin),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.ContainerVerticalMarrgin),
            
            imageViewContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageViewContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            imageViewContainer.topAnchor.constraint(equalTo: container.topAnchor),
            
            // the banner image should appear centered in the container
            // and fill the full width of the container
            bannerImageView.centerYAnchor.constraint(equalTo: imageViewContainer.centerYAnchor),
            bannerImageView.centerXAnchor.constraint(equalTo: imageViewContainer.centerXAnchor),
            bannerImageView.widthAnchor.constraint(greaterThanOrEqualTo: imageViewContainer.widthAnchor),
            
            verifiedLabel.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: -Self.VerifiedTextMargin),
            verifiedLabel.topAnchor.constraint(equalTo: imageViewContainer.topAnchor, constant: Self.VerifiedTextMargin),
            
            // the titleLabel should always be below the verified button AND the banner image
            titleLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: verifiedLabel.bottomAnchor, multiplier: 1),
            titleLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: imageViewContainer.bottomAnchor, multiplier: 1),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageViewContainer.leadingAnchor, constant: Self.TextHorizontalMargin),
            titleLabel.trailingAnchor.constraint(equalTo: imageViewContainer.trailingAnchor, constant: -Self.TextHorizontalMargin),
            
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Self.SummaryTopMargin),
            summaryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: Self.TextHorizontalMargin),
            summaryLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -Self.TextHorizontalMargin),
            
            findOutMoreButton.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: Self.FindOutMoreButtonVerticalMargin),
            findOutMoreButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            findOutMoreButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            findOutMoreButton.heightAnchor.constraint(equalToConstant: Self.FindOutMoreButtonHeight),
            
            findOutMoreButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Self.FindOutMoreButtonVerticalMargin)
        ]
        
        NSLayoutConstraint.activate(constraints)
        imageContainerHeight.isActive = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        setNeedsUpdateConstraints()
    }

    func configure(with petition: PresentedPetition) {

        bannerImageView.image = petition.image
        verifiedLabel.isHidden = !petition.isVerified
        titleLabel.text = petition.title
        summaryLabel.text = petition.summary
        
        setNeedsUpdateConstraints()
        setNeedsLayout()
    }

    @objc
    private func findOutMoreButtonTapped() {
        findOutMoreAction()
    }
}

// MARK: - Constants
extension PetitionTableViewCell {
        
    static let ContainerHorizontalMargin: CGFloat = 19
    static let ContainerVerticalMarrgin: CGFloat = 4
    static let PetitionImageHeight: CGFloat = 124
    static let VerifiedTextMargin: CGFloat = 10
    static let TitleTopMargin: CGFloat = 18
    static let TextHorizontalMargin: CGFloat = 15
    static let SummaryTopMargin: CGFloat = 7
    
    static let FindOutMoreButtonHeight: CGFloat = 50
    static let FindOutMoreButtonVerticalMargin: CGFloat = 15
    static let FindOutMoreButtonOutlineThickness: CGFloat = 2

    static let ContainerBackgroundColor = UIColor.white
    static let ContainerOutlineColor = UIColor.systemGray5
    static let ContainerOutlineThickness: CGFloat = 2

    static let ContentColor = UIColor.black
    
    static let VerifiedLabelTextColor = UIColor.white
    static let VerifiedLabelBackgroundColor = UIColor.black
}
