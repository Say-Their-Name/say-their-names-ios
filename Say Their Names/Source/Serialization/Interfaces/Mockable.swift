//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

// MARK: - Mockable
@objc protocol Mockable {
    static func mockJsonString() -> Serialization.StringType?
    static func mockDictionary() -> Serialization.DictionaryType?
    static func mockJson() -> Serialization.DataType?
}
