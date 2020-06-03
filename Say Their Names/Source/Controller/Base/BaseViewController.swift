//
//  BaseViewController.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BaseNibLoading, ServiceClient {
    let service: Service
    
    required init?(coder: NSCoder) { fatalError("") }
    required init(service: Service) {
        self.service = service
        
        let (bundle, name) = type(of: self).bundleAndNibName()
        super.init(nibName: name, bundle: bundle)
    }
}
