//
//  PersonController.swift
//  SayTheirNames
//
//  Created by Ahmad Karkouti on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonController: BaseViewController {
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var donateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "personView"

        // Do any additional setup after loading the view.
        setupLocalizedStrings()
    }
    
    private func setupLocalizedStrings() {
        if let readMore = NSLocalizedString("Read_More", comment: "Read More") as String? {
            self.readMoreButton.setTitle(readMore, for: UIControl.State.normal)
            self.readMoreButton.setTitle(readMore, for: UIControl.State.selected)
        } else {
            self.readMoreButton.setTitle("READ MORE ->", for: UIControl.State.normal)
            self.readMoreButton.setTitle("READ MORE ->", for: UIControl.State.selected)
        }
        
        if let donate = NSLocalizedString("Donate", comment: "Donate") as String? {
            self.donateButton.setTitle(donate, for: UIControl.State.normal)
            self.donateButton.setTitle(donate, for: UIControl.State.selected)
        } else {
            self.donateButton.setTitle("Donate", for: UIControl.State.normal)
            self.donateButton.setTitle("Donate", for: UIControl.State.selected)
        }
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
