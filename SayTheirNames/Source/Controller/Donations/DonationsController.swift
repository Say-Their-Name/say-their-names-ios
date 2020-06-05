//
//  DonationsController.swift
//  SayTheirNames
//
//  Created by Franck-Stephane Ndame Mpouli on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class DonationsController: BaseViewController {
    private let ui = DonationsView()
    
    required init(service: Servicing) {
        super.init(service: service)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = ui
    }
}
