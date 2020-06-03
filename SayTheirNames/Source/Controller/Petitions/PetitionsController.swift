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
    
    private lazy var viewCode = PetitionsViewCode()
    
    required init(service: Service, shouldInitWithNib: Bool) {
        super.init(service: service, shouldInitWithNib: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = viewCode
    }
}
