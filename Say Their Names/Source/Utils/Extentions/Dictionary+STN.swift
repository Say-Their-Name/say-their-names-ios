//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

public extension Dictionary where Key == String {
    func subscriptObject<ObjectType>(_ key: String, defaults: ObjectType) -> ObjectType {
        guard let result = self[key] as? ObjectType else { return defaults }
        
        return result
    }
    
    func subscriptDateObject<ObjectType>(_ key: String, defaults: ObjectType) -> ObjectType {
        guard let result = self[key] as? Double else { return defaults }
        
        return Date(timeIntervalSince1970: result) as! ObjectType
    }
    
    func subscriptDateWithSeconds<ObjectType>(_ key: String, defaults: ObjectType) -> ObjectType {
        guard let result = self[key] as? Double else { return defaults }
        
        return Date(timeIntervalSinceNow: result) as! ObjectType
    }
    
    func subscriptUrlObject<ObjectType>(_ key: String, defaults: ObjectType) -> ObjectType {
        guard let result = self[key] as? String else { return defaults }
        
        return URL(string: result) as! ObjectType
    }
    
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { self.updateValue($1, forKey: $0) }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        
        return dict
    }
}

