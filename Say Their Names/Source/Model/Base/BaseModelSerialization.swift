//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import CoreData

// MARK: - BaseModelSerializationKeys
struct BaseModelSerializationKeys {
    static let Id = "id"
}

// MARK: - BaseModelSerialization
class BaseModelSerialization: Serialization {
    public class func merge<B: BaseModelInterface, M: BaseModelInterface>(model: inout B, withModel: M, context: NSManagedObjectContext? = nil) {
        model.id = withModel.id
    }

    public class func update<B: BaseModelInterface>(model: inout B, fromDictionary dictionary: Serialization.DictionaryType, context: NSManagedObjectContext? = nil) {
        model.id = dictionary[BaseModelSerializationKeys.Id] as? Int ?? -1
    }
    
    public class func dictionary<B: BaseModelInterface>(fromModel: B) -> Serialization.DictionaryType? {
        return [BaseModelSerializationKeys.Id: fromModel.id]
    }
}
