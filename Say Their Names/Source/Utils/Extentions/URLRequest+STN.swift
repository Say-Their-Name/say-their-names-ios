//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension URLRequest {
    public var debugString: String {
        let data = self.httpBody ?? Data()
        let bodyData: Data? = data.count < 1000 ? data : "body is too big for logging".data(using: .utf8)
        let body =  String(data: bodyData ?? Data(), encoding: .utf8)
        
        return """
        Network Request:
            URL: \(self)
            Method: \(String(describing: self.httpMethod))
            Headers: \(String(describing: self.allHTTPHeaderFields))
            Body: \(String(describing: body))
        """
    }
}
