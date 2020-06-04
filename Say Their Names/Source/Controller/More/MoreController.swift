//
//  MoreController.swift
//  Say Their Names
//
//  Created by Hakeem King on 6/4/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class MoreController: BaseViewController {
    
    private let ui = MoreView()
    
    required init(service: Service) {
        super.init(service: service)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = ui
    }
}
