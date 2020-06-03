//
//  PersonInterface.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - UserInterface
protocol PersonInterface: BaseModelInterface {
    var fullName: String? { get set }
    var dob: Date? { get set }
    var doi: Date? { get set }
    var childrenCount: Int { get set }
    var age: Int { get set }
    var city: String? { get set }
    var country: String? { get set }
    var bio: String? { get set }
    var context: String? { get set }
    var images: [String]? { get set }
}
