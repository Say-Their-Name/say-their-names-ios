//
//  PetitionsController.swift
//  Say Their Names
//
//  Created by Franck-Stephane Ndame Mpouli on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// Controller responsible for showing the petitions
final class PetitionsController: BaseViewController {
    
    private let ui: PetitionsUI
    
    required init(service: Service, shouldInitWithNib: Bool) {
        self.ui = PetitionsUI()
        super.init(service: service, shouldInitWithNib: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = ui
    }
}
