//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

// MARK: - Serializable
@objc protocol Serializable {
    func deserialize(_ json: Serialization.DictionaryType?)
    func serialize() -> Serialization.DictionaryType?
    func serializedData() -> Serialization.DataType?
}
