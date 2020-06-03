//
//  Person.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

final class Person: BaseModel, PersonInterface {
    var fullName: String?
    var dob: Date?
    var doi: Date?
    var childrenCount: Int = 0
    var age: Int = 0
    var city: String?
    var country: String?
    var bio: String?
    var context: String?
    var images: [String]?
}

// MARK: - PersonMockable
typealias PersonMockable = Person
extension PersonMockable {
    override class func mockJsonString() -> String? {
        guard let dictionary = self.mockDictionary() else { return nil }
        
        return Serialization.jsonString(withData: dictionary)
    }
    
    override class func mockDictionary() -> Serialization.DictionaryType? {
        return [BaseModelSerializationKeys.Id: "some_random_id"]
    }
}

// MARK: - PersonLoggable
typealias PersonLoggable = Person
extension PersonLoggable {
    override func desc() -> String {
        return """
            \(super.desc())
            Full Name: \(String(describing: self.fullName))
            DOB: \(String(describing: self.dob))
        """
    }
}

// MARK: - PersonSerializable
typealias PersonSerializable = Person
extension PersonSerializable {
    override func deserialize(_ json: Serialization.DictionaryType?) {
        guard let dictionary = json else { return }
        
        super.deserialize(json)
        
        var tempSelf = self
        PersonSerialization.update(model: &tempSelf, fromDictionary: dictionary)
    }
    
    override func serialize() -> Serialization.DictionaryType? {
        return PersonSerialization.dictionary(fromModel: self)
    }
}
