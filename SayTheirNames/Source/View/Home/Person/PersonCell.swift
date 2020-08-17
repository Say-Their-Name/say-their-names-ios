//
//  PersonCell.swift
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

final class PersonCell: UICollectionViewCell {
    @DependencyInject private var dateFormatter: DateFormatterService
    @DependencyInject private var imageService: ImageService

    private lazy var profileImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFill
        imgV.clipsToBounds = true
        imgV.setContentHuggingPriority(.defaultLow, for: .vertical)
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.accessibilityIgnoresInvertColors = true
        return imgV
    }()
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(asset: STNAsset.Color.primaryLabel)
        lbl.lineBreakMode = .byTruncatingTail
        lbl.numberOfLines = 2
        lbl.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        lbl.setContentCompressionResistancePriority(.required - 1, for: .vertical)
        lbl.setContentHuggingPriority(.required, for: .vertical)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isAccessibilityElement = true
        lbl.accessibilityLabel = lbl.text
        return lbl
    }()
    
    private lazy var dateOfIncidentLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(asset: STNAsset.Color.secondaryLabel)
        lbl.lineBreakMode = .byTruncatingTail
        lbl.isAccessibilityElement = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentHuggingPriority(.required, for: .vertical)
        lbl.setContentCompressionResistancePriority(.required, for: .vertical)
        return lbl
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let bookmarkImage = UIImage(asset: STNAsset.Image.bookmark)
        let btn = UIButton(image: bookmarkImage)
        btn.contentMode = .scaleAspectFill
        btn.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        btn.setImage(bookmarkImage, for: .normal)
        btn.addTarget(self, action: #selector(didTapBookmark), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isAccessibilityElement = true
        btn.isHidden = !FeatureFlags.bookmarksEnabled
        return btn
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setContentHuggingPriority(.required, for: .vertical)
        return stack
    }()
    
    private lazy var labelsAndButtonContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
        
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .center
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with person: Person) {
        imageService.populate(imageView: profileImageView, withURLString: person.images.first?.personURL)
        nameLabel.text = person.fullName.localizedUppercase
        dateOfIncidentLabel.text = self.dateFormatter.dateOfIncidentString(from: person.doi)
    }
    
    private func setUp() {
        labelsAndButtonContainer.addSubview(nameLabel)
        labelsAndButtonContainer.addSubview(dateOfIncidentLabel)
        labelsAndButtonContainer.addSubview(bookmarkButton)

        containerStack.addArrangedSubview(profileImageView)
        containerStack.addArrangedSubview(labelsAndButtonContainer)
        
        var constraints: [NSLayoutConstraint] = [
            nameLabel.topAnchor.constraint(equalTo: labelsAndButtonContainer.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: labelsAndButtonContainer.leadingAnchor),

            dateOfIncidentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateOfIncidentLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateOfIncidentLabel.bottomAnchor.constraint(lessThanOrEqualTo: labelsAndButtonContainer.bottomAnchor),
            dateOfIncidentLabel.trailingAnchor.constraint(equalTo: labelsAndButtonContainer.trailingAnchor),

            profileImageView.heightAnchor.constraint(equalToConstant: Theme.Screens.Home.CellSize.peopleHeight * 0.85),
        ]
        
        if FeatureFlags.bookmarksEnabled {
            constraints.append(contentsOf: [
                nameLabel.trailingAnchor.constraint(equalTo: bookmarkButton.leadingAnchor, constant: 4),
                bookmarkButton.trailingAnchor.constraint(equalTo: labelsAndButtonContainer.trailingAnchor),
                bookmarkButton.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            ])
        }
        else {
            constraints.append(contentsOf: [
                nameLabel.trailingAnchor.constraint(equalTo: labelsAndButtonContainer.trailingAnchor)
            ])
        }
        
        NSLayoutConstraint.activate(constraints)
        
        containerStack.addArrangedSubview(profileImageView)
        containerStack.addArrangedSubview(labelsAndButtonContainer)
        addSubview(containerStack)
        containerStack.fillSuperview()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        styleLabels()
    }
    
    private func styleLabels() {
        nameLabel.font = UIFont.STN.cardTitle
        dateOfIncidentLabel.font = UIFont.STN.cardSubitle
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            styleLabels()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.profileImageView.image = nil
        self.nameLabel.text = ""
        self.dateOfIncidentLabel.text = ""
    }
    
    // MARK: - Handlers
        
    @objc private func didTapBookmark() {
        Log.print(#function)
    }
}
