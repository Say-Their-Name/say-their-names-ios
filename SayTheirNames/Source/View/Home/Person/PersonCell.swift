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
    static let personIdentifier = "personCell"
    
    private lazy var profileImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "man-in-red-jacket-1681010")
        imgV.contentMode = .scaleAspectFill
        imgV.clipsToBounds = true
        imgV.setContentHuggingPriority(.defaultLow, for: .vertical)
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.accessibilityIgnoresInvertColors = true
        return imgV
    }()
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "GEORGE FLOYD"
        lbl.textColor = UIColor.STN.primaryLabel
        lbl.lineBreakMode = .byTruncatingTail
        lbl.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.isAccessibilityElement = true
        lbl.accessibilityLabel = lbl.text
        return lbl
    }()
    
    private lazy var dateOfIncidentLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "25.05.2020"
        lbl.textColor = UIColor.STN.secondaryLabel
        lbl.lineBreakMode = .byTruncatingTail
        lbl.isAccessibilityElement = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let bookmarkImage = UIImage(named: "bookmark")
        let btn = UIButton(image: bookmarkImage)
        btn.contentMode = .scaleAspectFill
        btn.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        btn.setImage(UIImage(named: "bookmark"), for: .normal)
        btn.addTarget(self, action: #selector(didTapBookmark), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isAccessibilityElement = true
        return btn
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
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
        profileImageView.populate(withURL: person.images.first?.personURL ?? "")
        nameLabel.text = person.fullName.uppercased()
        dateOfIncidentLabel.text = person.doi
    }
    
    private func setUp() {
        labelsAndButtonContainer.addSubview(nameLabel)
        labelsAndButtonContainer.addSubview(dateOfIncidentLabel)
        labelsAndButtonContainer.addSubview(bookmarkButton)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: labelsAndButtonContainer.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: labelsAndButtonContainer.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: bookmarkButton.leadingAnchor, constant: 4),

            dateOfIncidentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateOfIncidentLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateOfIncidentLabel.bottomAnchor.constraint(equalTo: labelsAndButtonContainer.bottomAnchor, constant: -20),
            dateOfIncidentLabel.trailingAnchor.constraint(equalTo: labelsAndButtonContainer.trailingAnchor),

            bookmarkButton.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: labelsAndButtonContainer.trailingAnchor)
        ])
        
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

    // MARK: - Handlers
        
    @objc private func didTapBookmark() {
        Log.print(#function)
    }
}
