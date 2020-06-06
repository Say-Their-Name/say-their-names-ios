//
//  PersonInfoTableViewCell.swift
//  Say Their Names
//
//  Created by Manase on 04/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonInfoTableViewCell: UITableViewCell {

    static var reuseIdentifier: String {
        return "\(Self.self)"
    }
    
    lazy var containerStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [infoStackView, extraInfoStack])
        view.distribution = .fillEqually
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    lazy var infoStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameContainerStack])
        view.distribution = .fill
        view.axis = .horizontal
        view.alignment = .fill
        view.spacing = 10
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
        view.spacing = 8
        return view
    }()
       
    lazy var nameContainerStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [nameLabel, verticalSeparatorView])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = 10
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
        label.textColor = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1)
        label.font = UIFont.STN.bannerTitle
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var ageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "AGE"
        label.textColor = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 0.5)
        label.font = UIFont.STN.detailViewFieldTitle
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var childrenTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "CHILDREN"
        label.textColor = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 0.5)
        label.font = UIFont.STN.detailViewFieldTitle
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "LOCATION"
        label.textColor = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 0.5)
        label.font = UIFont.STN.detailViewFieldTitle
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "46"
        label.textColor = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1)
        label.font = UIFont.STN.detailViewField
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var childrenLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.textColor = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1)
        label.font = UIFont.STN.detailViewField
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Missisippi, Denver Cloud Source, United States of America"
        label.textColor = UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1)
        label.font = UIFont.STN.detailViewField
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var verticalSeparatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 0.4)
        return view
    }()
    
    lazy var horizontalSeparatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 0.4)
        return view
    }()
    
    lazy var secondHorizontalSeparatorView: UIView = {
           let view = UIView(frame: .zero)
           view.backgroundColor = UIColor(red: 196/255.0, green: 196/255.0, blue: 196/255.0, alpha: 0.4)
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
        ageLabel.text = person.age
        childrenLabel.text = person.childrenCount
        locationLabel.text = person.country.uppercased()
    }
    
    private func setupLayout() {
        containerStack.fillSuperview(superView: contentView, padding: .init(top: 32, left: 32, bottom: 0, right: 16))
        ageContainerStack.widthAnchor.constraint(equalToConstant: 60).isActive = true
        childrenContainerStack.widthAnchor.constraint(equalToConstant: 90).isActive = true
        locationContainerStack.widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        verticalSeparatorView.anchor(size: .init(width: 150, height: 1.5))
        horizontalSeparatorView.anchor(size: .init(width: 1.5, height: 30))
        secondHorizontalSeparatorView.anchor(size: .init(width: 1.5, height: 30))

    }
}
