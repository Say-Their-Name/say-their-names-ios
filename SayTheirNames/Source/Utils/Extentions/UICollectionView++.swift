//
//  UICollectionView++.swift
//  Say Their Names
//
//  Created by Leonardo Garcia  on 02/06/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension UICollectionView {
    /// Registers the cell into the collectionView using a reuseIdentifier coming from the `Reusable` protocol
    func register(cellType type: UICollectionViewCell.Type) {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }

    /// Dequeues a generic cell from the collection view using the reuseIdentifier coming from the `Reusable` protocol.
    /// Note that the cell must be registered before into the collection view with the same reuseIdentifier.
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("You need to register cell of type `\(T.reuseIdentifier)`")
        }
        
        return cell
    }
}
