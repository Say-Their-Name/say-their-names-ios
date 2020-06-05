//
//  HeaderCellContent.swift
//  SayTheirNames
//
//  Created by Thomas Murray on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

//TODO: - replace with actual model for header cell
struct HeaderCellContent: Hashable {
    let id = UUID()
    let title: String?
    let description: String?
}
