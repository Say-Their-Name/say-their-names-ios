//
//  ServiceClient.swift
//  Say Their Names
//
//  Created by Joseph A. Wardell on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

protocol ServiceClient {
    var service : Service { get }
    
    init(service: Service)
}

