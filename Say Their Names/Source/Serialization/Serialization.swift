//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit
import CoreData

// MARK: - Serialization
class Serialization: NSObject {
    public class func jsonString(withData data: Serialization.AnyType) -> Serialization.StringType? {
        do {
            let parsedData = try self.data(withJSONObject: data)
            
            return String(data: parsedData, encoding: .utf8)
        }
        catch {
            Log.print("\(error)")
        }

        return nil
    }
    
    public class func jsonObject(with data: Serialization.DataType) throws -> Serialization.AnyType  {
        return try JSONSerialization.jsonObject(with: data)
    }
    
    public class func data(withJSONObject obj: Serialization.AnyType) throws -> Serialization.DataType {
        return try JSONSerialization.data(withJSONObject: obj)
    }
}

// MARK: - SerializationTypes
extension Serialization {
    typealias DataType          = Data
    typealias AnyType           = Any
    typealias StringType        = String
    typealias DictionaryType    = [String: Any]
    typealias ArrayType         = [Any]
}
