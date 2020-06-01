//
//  PersonController.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didPressReadButton(_ sender: Any) {
        let controller = PersonDetailsController(nibName: "PersonDetailsController", bundle: nil)
        controller.isModalInPresentation = true
        navigationController?.pushViewController(controller, animated: true)
      }
    
}
