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
    static let Country          = "country"
    static let Biography        = "biography"
    static let context          = "context"
    static let Images           = "images"
}

final class PersonSerialization: BaseModelSerialization {
    public override class func update<B: BaseModelInterface>(model: inout B, fromDictionary dictionary: Serialization.DictionaryType, context: NSManagedObjectContext? = nil) {
        super.update(model: &model, fromDictionary: dictionary, context: context)
        
        guard let model = model as? PersonInterface else { return }
        model.fullName = dictionary.subscriptObject(PersonSerializableKeys.FullName, defaults: nil)
        //model.dob = dictionary.subscriptDateObject(PersonSerializableKeys.DOB, defaults: nil)
        //model.doi = dictionary.subscriptDateObject(PersonSerializableKeys.DOI, defaults: nil)
        model.childrenCount = dictionary.subscriptObject(PersonSerializableKeys.NumberOfChildren, defaults: 0)
        model.age = dictionary.subscriptObject(PersonSerializableKeys.Age, defaults: 0)
        model.city = dictionary.subscriptObject(PersonSerializableKeys.City, defaults: nil)
        model.country = dictionary.subscriptObject(PersonSerializableKeys.Country, defaults: nil)
        model.bio = dictionary.subscriptObject(PersonSerializableKeys.Biography, defaults: nil)
        model.context = dictionary.subscriptObject(PersonSerializableKeys.context, defaults: nil)
        
        // Images
        //model.images = dictionary.subscriptObject(PersonSerializableKeys.context, defaults: nil)
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
