//
//  PresentedPetition.swift
//  Say Their Names
//
//  Created by Joseph A. Wardell on 6/4/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// A view model protocol to represent an object that is presented in PetitionsViewController
///
/// For now, we're just using MockPetition
//
/// but in the future, objects returned from network calls will implement this protocol
/// (or created view model structs that implement it, it doesn't matter)
protocol PresentedPetition {
    var title: String { get }
    var summary: String { get }
    var image: UIImage? { get }
    var isVerified: Bool { get }
}
