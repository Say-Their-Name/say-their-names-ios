//
//  SettingsController.swift
//  Say Their Names
//
//  Created by Manase on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class SettingsController: BaseViewController {
    
    private let ui = SettingsView()
    
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
