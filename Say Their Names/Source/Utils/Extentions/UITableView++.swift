//
//  UITableView++.swift
//  Say Their Names
//
//  Created by Mert Vardar on 3.06.2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension UITableView {
    /// Registers the cell into the tableView using a reuseIdentifier coming from the `Reusable` protocol
    func register(cellType type: UITableViewCell.Type) {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }

    /// Dequeues a generic cell from the table view using the reuseIdentifier coming from the `Reusable` protocol.
    /// Note that the cell must be registered before into the table view with the same reuseIdentifier.
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("You need to register cell of type `\(T.reuseIdentifier)`")
        }
        
        return cell
    }
}
