//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - STNError
class STNError: Error {
    public var code: Int?
    public var message: String?
    public var description : String?
    
    init(code: Int = 0, message: String? = nil, description: String? = nil) {
        self.code = code
        self.message = message
        self.description = description
    }
}
