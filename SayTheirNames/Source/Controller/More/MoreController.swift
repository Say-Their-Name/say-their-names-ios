//
//  MoreController.swift
//  SayTheirNames
//
//  Created by Hakeem King on 6/5/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class MoreController: UIViewController, ServiceReferring {
    var service: Servicing
    private let moreView = MoreView()

    required init(service: Servicing) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("This should not be called") }

    override func loadView() {
        self.view = moreView
    }
}
