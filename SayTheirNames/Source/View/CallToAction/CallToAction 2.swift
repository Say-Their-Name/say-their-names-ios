//
//  CallToAction.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

protocol CallToAction {
    var actionTitle: String { get }
    var imagePath: String? { get }
    var body: String { get }
    var tag: String? { get }
    var title: String { get }
}
