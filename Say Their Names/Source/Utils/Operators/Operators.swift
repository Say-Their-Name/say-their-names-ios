//
//  Operators.swift
//  Say Their Names
//
//  Created by Kyle Lee on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

precedencegroup OperationChaining {
    associativity: left
}
infix operator ==> : OperationChaining

/// Makes the left operation dependent on the completion of
/// the right operation.
/// - Returns: The right operation for additional chaining
@discardableResult
func ==><T: Operation>(lhs: T, rhs: T) -> T {
    rhs.addDependency(lhs)
    return rhs
}
