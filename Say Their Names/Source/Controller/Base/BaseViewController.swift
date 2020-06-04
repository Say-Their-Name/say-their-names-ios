//
//  BaseViewController.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let service: Service
    
    required init?(coder: NSCoder) { fatalError("") }
    
    required init(service: Service) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
}
