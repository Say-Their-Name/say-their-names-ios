//
//  PetitionDetailViewController.swift
//  Say Their Names
//
//  Created by Joseph A. Wardell on 6/4/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class PetitionDetailViewController: UIViewController, ServiceReferring {
    
    var service: Service
    var petition: PresentedPetition?
    
    private let petitionDetailView = PetitionDetailView()
    
    required init(service: Service) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("This should not be called") }

    convenience init(service: Service, petition: PresentedPetition) {
        self.init(service: service)
        self.petition = petition
    }
    
    override func loadView() {
        self.view = petitionDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        petitionDetailView.dismissButton.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        petitionDetailView.set(petition: petition)
    }

    @objc
    private func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }
}
