//
//  UIViewController+STN.swift
//  SayTheirNames
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

public protocol BaseNibLoading {
    static func bundleAndNibName() -> (Bundle, String)
}

extension BaseNibLoading where Self: BaseViewController {
    static func bundleAndNibName() -> (Bundle, String) {
        return (Bundle(for: Self.self), String(describing: self))
    }
}
