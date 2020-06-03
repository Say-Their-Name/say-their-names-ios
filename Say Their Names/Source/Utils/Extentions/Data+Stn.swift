//
//  Data+Stn.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension Data {
    public func toString() -> String? {
        guard self.count > 0 else { return nil }
        
        return String(data: self, encoding: .utf8)
    }
    
    public func dispatchBase64Encode(_ completion: @escaping (String) -> Void) {
        DispatchQueue.global {
            let base64EncodedString = self.base64EncodedString()
            DispatchQueue.mainAsync {
                completion(base64EncodedString)
            }
        }
    }
}
