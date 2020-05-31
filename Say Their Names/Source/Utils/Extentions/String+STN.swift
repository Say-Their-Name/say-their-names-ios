//
//  String+STN.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - String
public extension String {
    var nsstring: NSString {
        return self as NSString
    }
    
    var lastPathComponent: String {
        return nsstring.lastPathComponent
    }
    
    var stringByDeletingPathExtension: String {
        return nsstring.deletingPathExtension
    }
    
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    var base64Encoded: String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        
        return data.base64EncodedString()
    }
    
    var base64Decoded: String? {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions()) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}
