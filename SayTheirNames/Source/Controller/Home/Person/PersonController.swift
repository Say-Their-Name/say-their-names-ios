//
//  PersonController.swift
//  SayTheirNames
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "personView"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didPressReadButton(_ sender: Any) {
        let personDetailsController = PersonDetailsController(service: self.service)
        personDetailsController.isModalInPresentation = true
        navigationController?.pushViewController(personDetailsController, animated: true)
      }
    
}
