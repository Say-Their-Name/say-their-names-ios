//
//  DMDPhotoSupplementaryView.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class DMDPhotoSupplementaryView: UICollectionReusableView {
    // MARK: - Property
    static let reuseIdentifier = "donations-more-details-photo-view"
    
    // MARK: - View
    let imageWithBlurView = ImageWithBlurView(frame: .zero)
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .red
        clipsToBounds = true
        imageWithBlurView.fillSuperview(superView: self, padding: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method
    public func configure(_ person: Person) {
        imageWithBlurView.setup(person)
    }
}
