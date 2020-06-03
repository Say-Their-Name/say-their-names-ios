//
//  BaseViewController.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BaseNibLoading {
    let service: Service
    
    required init?(coder: NSCoder) { fatalError("") }
    
    // TODO: `shouldInitWithNib` should be removed when UI is refactored
    // to be completely programmatic
    required init(service: Service, shouldInitWithNib: Bool = true) {
        self.service = service
        
        if shouldInitWithNib {
            let (bundle, name) = type(of: self).bundleAndNibName()
            super.init(nibName: name, bundle: bundle)
        } else {
            super.init(nibName: nil, bundle: nil)
        }
    }
}
