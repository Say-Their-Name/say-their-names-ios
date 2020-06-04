//
//  PetitionsController.swift
//  Say Their Names
//
//  Created by Franck-Stephane Ndame Mpouli on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// Controller responsible for showing the petitions
final class PetitionsController: UIViewController, ServiceReferring {
    var service: Service
    
    private lazy var petitionsView = PetitionsView(title: Strings.petitions.uppercased())
    private var petitionsTableView: UITableView { petitionsView.tableView }

    private lazy var dataSource: PetitionsTableViewDataSource = {
        
        let dataSource = PetitionsTableViewDataSource()
        dataSource.configure(tableView: petitionsTableView)
        
        dataSource.findOutMoreAction = { [weak self] petition in
            
            self?.showDetailViewController(for: petition)
        }
        return dataSource
    }()
    
    required init(service: Servicing) {
        super.init(service: service)
    }
    
    required init?(coder: NSCoder) { fatalError("This should not be called") }

    override func loadView() {
        self.view = petitionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        petitionsTableView.delegate = self
        
        // build mock data for display now
        // in the future, we'll get petitions from the network
        let longTitle = "Editing the new edition of revolution"
        let shortTitle = "Justice for George Floyd"
        
        let dummyPetitions = [
            MockPetition(title: longTitle, verified: true, hasImage: true),
            MockPetition(title: longTitle, verified: false, hasImage: false),
            MockPetition(title: longTitle, verified: true, hasImage: true),
            MockPetition(title: longTitle, verified: true, hasImage: false),
            MockPetition(title: shortTitle, verified: true, hasImage: true),
            MockPetition(title: shortTitle, verified: true, hasImage: false),
            MockPetition(title: shortTitle, verified: false, hasImage: true),
            MockPetition(title: shortTitle, verified: true, hasImage: false)
        ]
        
        dataSource.set(petitions: dummyPetitions)
    }
        
    private func showDetailViewController(for petition: PresentedPetition) {
        
        // People CollectionView
        // let selectedPerson = peopleDataSource.fetchPerson(at: indexPath.item)
        let detailViewController = PetitionDetailViewController(service: service, petition: petition)
        
        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.navigationBar.isHidden = true
        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension PetitionsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        // there's no real selected state in this design,
        // we simply show another view controller when the find out more button is tapped
        false
    }
}
