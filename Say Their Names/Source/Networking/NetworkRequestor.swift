//
//  NetworkRequestor.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

class NetworkRequestor: NSObject, ServiceReferring {
    weak var service: Service?
    let concurrentQueue = DispatchQueue(label: "NetworkRequestor", attributes: .concurrent)
    
    // MARK: - Public methods
    
    required init(service: Service) {
        self.service = service
    }
}
