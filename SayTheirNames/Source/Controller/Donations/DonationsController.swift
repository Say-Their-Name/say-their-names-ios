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
    
    override func viewDidLoad() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        ui.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapped() {
        let detailVC = DonationsMoreDetailsController(service: service)
        let navigationController = UINavigationController(rootViewController: detailVC)
        present(navigationController, animated: true, completion: nil)
    }
}
