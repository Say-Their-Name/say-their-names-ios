//
//  PersonInfoTableViewCell.swift
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

class PersonInfoTableViewCell: UITableViewCell {

    static var reuseIdentifier: String {
        return "\(Self.self)"
    }
    
    lazy var containerStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [infoStackView, extraInfoStack])
        view.distribution = .fill
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = Theme.Screens.Home.Person.stackViewSpacing
        return view
    }()
    
    lazy var infoStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameContainerStack])
        view.distribution = .fill
        view.axis = .horizontal
        view.alignment = .fill
        view.spacing = Theme.Screens.Home.Person.stackViewSpacing
        return view
    }()
    
    lazy var extraInfoStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            ageContainerStack,
            horizontalSeparatorView,
            childrenContainerStack,
            secondHorizontalSeparatorView,
            locationContainerStack
        ])
        view.distribution = .fill
        view.alignment = .top
        view.axis = .horizontal
        view.spacing = Theme.Screens.Home.Person.stackViewSpacing
        return view
    }()
       
    lazy var nameContainerStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, verticalSeparatorView])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = Theme.Screens.Home.Person.stackViewSpacing
        return view
    }()
    
    lazy var ageContainerStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [ageTitleLabel, ageLabel])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = 0
        return view
    }()
    
    lazy var childrenContainerStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [childrenTitleLabel, childrenLabel])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = 0
        return view
    }()
    
    lazy var locationContainerStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [locationTitleLabel, locationLabel])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = 0
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "FIRSTNAME LAST"
        label.textColor = UIColor(asset: STNAsset.Color.detailLabel)
        label.font = UIFont.STN.bannerTitle
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var ageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Person.age.uppercased()
        label.textColor = UIColor(asset: STNAsset.Color.lightHeader)
        label.font = UIFont.STN.detailViewFieldTitle
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var childrenTitleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Person.children.uppercased()
        label.textColor = UIColor(asset: STNAsset.Color.lightHeader)
        label.font = UIFont.STN.detailViewFieldTitle
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Person.location.uppercased()
        label.textColor = UIColor(asset: STNAsset.Color.lightHeader)
        label.font = UIFont.STN.detailViewFieldTitle
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "46"
        label.textColor = UIColor(asset: STNAsset.Color.detailLabel)
        label.font = UIFont.STN.detailViewField
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var childrenLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.textColor = UIColor(asset: STNAsset.Color.detailLabel)
        label.font = UIFont.STN.detailViewField
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Missisippi, Denver Cloud Source, United States of America"
        label.textColor = UIColor(asset: STNAsset.Color.detailLabel)
        label.font = UIFont.STN.detailViewField
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var verticalSeparatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(asset: STNAsset.Color.separator)
        return view
    }()
    
    lazy var horizontalSeparatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(asset: STNAsset.Color.separator)
        return view
    }()
    
    lazy var secondHorizontalSeparatorView: UIView = {
           let view = UIView(frame: .zero)
           view.backgroundColor = UIColor(asset: STNAsset.Color.separator)
           return view
       }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(_ person: Person) {
        nameLabel.text = person.fullName.uppercased()
        ageLabel.text = person.age.flatMap({ "\($0)" })
        childrenLabel.text = person.childrenCount.flatMap({ "\($0)" })
        locationLabel.text = person.country.uppercased()
    }
    
    private func setupLayout() {
        containerStack.fillSuperview(superView: contentView,
                                     padding: .init(top: Theme.Components.Padding.large,
                                                    left: Theme.Components.Padding.large,
                                                    bottom: 0,
                                                    right: Theme.Components.Padding.medium))
        ageContainerStack.widthAnchor.constraint(equalToConstant: Theme.Screens.Home.Person.Info.ageConatinerWidth).isActive = true
        childrenContainerStack.widthAnchor.constraint(equalToConstant: 90).isActive = true
        locationContainerStack.widthAnchor.constraint(greaterThanOrEqualToConstant: Theme.Screens.Home.Person.Info.locationContainerWidth)
            .isActive = true
        verticalSeparatorView.anchor(size: Theme.Screens.Home.Person.Info.verticalSeperatorSize)
        horizontalSeparatorView.anchor(size: Theme.Screens.Home.Person.Info.horizontalSeperatorSize)
        secondHorizontalSeparatorView.anchor(size: Theme.Screens.Home.Person.Info.horizontalSeperatorSize)

    }
}
