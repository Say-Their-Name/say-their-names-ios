//
//  PersonPhotoTableViewCell.swift
//  Say Their Names
//
//  Created by Manase on 04/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonPhotoTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return "\(Self.self)"
    }
    
    // MARK: - View
    let imageWithBlurView = ImageWithBlurView(frame: .zero)
        
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .red
        contentView.clipsToBounds = true
        imageWithBlurView.fillSuperview(superView: contentView, padding: .zero)
        accessibilityTraits.insert(.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method
    public func setupCell(_ person: Person) {
        imageWithBlurView.setup(person)
        accessibilityLabel = "\(person.fullName)"
    }
}
