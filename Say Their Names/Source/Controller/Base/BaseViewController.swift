//
//  BaseViewController.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    public weak var service: Service!
    
    public class func controllerForType<T: BaseViewController>(_ vcType: T.Type, withService: Service) -> T {
        let controller = vcType.init()
        controller.service = withService
        
        return controller
    }
}
