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
        return imgV
    }()
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "GEORGE FLOYD"
        lbl.font = UIFont(name: "Karla-Bold", size: 13)
        lbl.textColor = UIColor.STN.primaryLabel
        lbl.lineBreakMode = .byTruncatingTail
        lbl.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var dateOfIncidentLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "25.05.2020"
        lbl.font = UIFont(name: "Karla-regular", size: 13)
        lbl.textColor = UIColor.STN.secondaryLabel
        lbl.lineBreakMode = .byTruncatingTail
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

    private lazy var detailsVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var bottomCellHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        detailsVStack.addArrangedSubview(nameLabel)
        detailsVStack.addArrangedSubview(dateOfIncidentLabel)
        bottomCellHStack.addArrangedSubview(detailsVStack)
        bottomCellHStack.addArrangedSubview(bookmarkButton)
        containerStack.addArrangedSubview(profileImageView)
        containerStack.addArrangedSubview(bottomCellHStack)
        addSubview(containerStack)
        profileImageView.anchor(top: topAnchor,
                                leading: leadingAnchor,
                                bottom: bottomCellHStack.topAnchor,
                                trailing: trailingAnchor,
                                padding: .init(top: 10,
                                               left: 0,
                                               bottom: 10,
                                               right: 0))
        bookmarkButton.anchor(top: nil,
                              leading: nil,
                              bottom: nil,
                              trailing: trailingAnchor)
        containerStack.anchor(top: topAnchor,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor)
    }

    // MARK: - Handlers
        
    @objc private func didTapBookmark() {
        // TODO: Implement BookMark Handler
    }
}
