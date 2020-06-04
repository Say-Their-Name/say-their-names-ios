//
//  PetitionsTableViewDataSource.swift
//  Say Their Names
//
//  Created by Joseph A. Wardell on 6/4/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class PetitionsTableViewDataSource: NSObject {

    var findOutMoreAction: (PresentedPetition) -> Void = { _ in }
    
    private(set) var petitions: [PresentedPetition] = []
    private(set) var tableView: UITableView?
    
    func set(petitions: [PresentedPetition]) {
        self.petitions = petitions
        tableView?.reloadData()
    }
    
    func configure(tableView: UITableView) {
        tableView.register(cellType: PetitionTableViewCell.self)
        tableView.dataSource = self
        
        self.tableView = tableView
    }
}

// MARK: - UITableViewDataSource
extension PetitionsTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        petitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PetitionTableViewCell = tableView.dequeueCell(for: indexPath)
        let petition = petitions[indexPath.item]
        cell.configure(with: petition)
        cell.findOutMoreAction = { [weak self] in
            self?.findOutMoreAction(petition)
        }
        return cell
    }
}
