//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

class BaseNetworkUrl {
    typealias UrlString = String
    
    class var base: UrlString {
        #if DEV
            return "https://saytheirnames.dev"
        #elseif QA
            return "https://saytheirnames.qa"
        #elseif LOCAL
            return "https://localhost"
        #else
            return "https://saytheirnames.dev" // switch to PROD
        #endif
    }
}
