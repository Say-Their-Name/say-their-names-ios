//
//  SayTheirNames
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

enum Environment {
    static let serverURLString: String = {
        #if DEV
            return "https://saytheirnames.dev"
        #elseif QA
            return "https://saytheirnames.qa"
        #elseif LOCAL
            return "https://localhost"
        #else
            return "https://saytheirnames.dev" // switch to PROD
        #endif
    }()
}
