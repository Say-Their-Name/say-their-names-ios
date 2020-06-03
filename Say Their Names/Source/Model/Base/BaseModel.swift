//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - BaseModel
protocol BaseType {

}

// MARK: - BaseModelReturn
@objc protocol BaseModelReturn {
    var modelClass: BaseModel.Type { get }
    var model: BaseModel? { get }
}

// MARK: - BaseModel
class BaseModel: NSObject {
    public var id: Int = -1

    required init(_ dictionary: Serialization.DictionaryType? = nil) {
        super.init()
        self.deserialize(dictionary)
    }
    
    override var description: String {
        var description = super.description
        description.append("\n\(self.desc())")
        
        return description
    }
}

// MARK: - BaseModelLoggable
typealias BaseModelLoggable = BaseModel
extension BaseModelLoggable: Loggable {
    func desc() -> String {
        return """
        ID: \(String(describing: self.id))
        """
    }
}

// MARK: - Mockable
extension BaseModel: Mockable {
    public class func mockJsonString() -> Serialization.StringType? { return nil }
    
    public class func mockDictionary() -> Serialization.DictionaryType? { return nil }
    
    public class func mockJson() -> Serialization.DataType? {
        guard let mockString = self.mockJsonString() else { return nil }
        
        return mockString.data(using: .utf8)
    }
}

// MARK: - Serializable
extension BaseModel: Serializable {
    func deserialize(_ json: Serialization.DictionaryType?) {
        guard let json = json else { return }
        self.id = json.subscriptObject(BaseModelSerializationKeys.Id, defaults: self.id)
    }
    
    func serialize() -> Serialization.DictionaryType? {
        var dict: Serialization.DictionaryType = [:]
        dict[BaseModelSerializationKeys.Id] = self.id
        
        return dict
    }
    
    func serializedData() -> Serialization.DataType? {
        guard let dictionary = self.serialize() else { return nil }
        
        return try? Serialization.data(withJSONObject: dictionary)
    }
}
