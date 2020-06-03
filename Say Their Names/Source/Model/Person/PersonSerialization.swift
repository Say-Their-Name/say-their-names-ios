//
//  PersonSerialization.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit
import CoreData

// MARK: - PersonSerializationKeys
struct PersonSerializableKeys {
    static let FullName         = "full_name"
    static let DOB              = "date_of_birth"
    static let DOI              = "date_of_incident"
    static let NumberOfChildren = "number_of_children"
    static let Age              = "age"
    static let City             = "city"
    static let County           = "country"
    static let Biography        = "biography"
    static let context          = "context"
    static let Images           = "images"
}

final class PersonSerialization: BaseModelSerialization {
    public override class func update<B: BaseModelInterface>(model: inout B, fromDictionary dictionary: Serialization.DictionaryType, context: NSManagedObjectContext? = nil) {
        super.update(model: &model, fromDictionary: dictionary, context: context)
        
        guard let model = model as? PersonInterface else { return }
        model.fullName = dictionary.subscriptObject(PersonSerializableKeys.FullName, defaults: nil)
    }
    
    public override class func dictionary<B: BaseModelInterface>(fromModel model: B) -> Serialization.DictionaryType? {
        guard let model = model as? Person else { return nil }
        
        var dict: Serialization.DictionaryType! = super.dictionary(fromModel: model)
        
        if dict != nil {
            dict[PersonSerializableKeys.FullName] = model.fullName
        }
        
        return dict
    }
}
