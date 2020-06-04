//
//  FileDataProvider.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

/// Provides data for a file
protocol FileDataProvider {
    /// The file data
    var fileData: Data? { get }
}
