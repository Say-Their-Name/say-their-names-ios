//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//
import Foundation

// MARK: - BaseError
public protocol BaseError: Error {
    var localizedDescription: String { get }
    var code: Int? { get }
}
