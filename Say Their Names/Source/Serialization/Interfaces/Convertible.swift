//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Convertible
@objc protocol Convertible {
    
}

// MARk: - ModelConvertible
@objc protocol ModelConvertible: Convertible {
    func convert(fromModel: BaseModel?)
    func convertToModel() -> BaseModel?
}

// MARK: - ManagedObjectConvertible
@objc protocol ManagedObjectConvertible: Convertible {
    //func convert(fromManagedObject: BaseManagedObject?)
    //func convertToManagedObject(inContext: NSManagedObjectContext, managedContext: ManagedContext?) -> BaseManagedObject?
}
