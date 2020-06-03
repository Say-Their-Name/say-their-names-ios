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
    public var description : String {
        get { return "STNError" }
    }
}
