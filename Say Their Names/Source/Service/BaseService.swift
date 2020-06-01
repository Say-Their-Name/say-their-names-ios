//
//  BaseServiceiewController.swift
//  Say Their Names
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - BaseService
class BaseService {
    public weak var service: Service?
    
    init(service: Service) {
        self.service = service
    }
}
