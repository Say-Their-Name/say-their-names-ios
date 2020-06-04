//
//  MockPetition.swift
//  Say Their Names
//
//  Created by Joseph A. Wardell on 6/4/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// This is a mock PresentedPetition implementation  that's meant to be used to test the layout of PetitionCollectionViewCell
///
/// Once we have real data coming from the server, this will not be needed
///
/// It uses data from the Figma page
struct MockPetition: PresentedPetition {
    
    let title: String
    
    var summary: String { "Following the tragic news surrounding the murder of George Floyd by Minneapolis police officers…" }
    
    var image: UIImage? {
        hasImage ? UIImage(named: "Group 6") : nil
    }
    
    let isVerified: Bool
    let hasImage: Bool
    
    init(title: String, verified: Bool, hasImage: Bool) {
        self.title = title
        self.isVerified = verified
        self.hasImage = hasImage
    }
}
