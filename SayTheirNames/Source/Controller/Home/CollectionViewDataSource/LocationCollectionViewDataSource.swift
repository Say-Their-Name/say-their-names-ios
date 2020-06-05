//
//  LocationCollectionViewDataSource.swift
//  SayTheirNames
//
//  Created by JohnAnthony on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class LocationCollectionViewDataSourceHelper {
    
    enum Section {
        case main
    }
    
    typealias LocationCollectionViewDataSource = UICollectionViewDiffableDataSource<Section, Location>
    
    let dataSource: LocationCollectionViewDataSource
    
    init(collectionView: UICollectionView) {
        collectionView.register(cellType: LocationCell.self)

        self.dataSource =
            LocationCollectionViewDataSource(collectionView: collectionView) { (collectionView, indexPath, location) -> UICollectionViewCell? in
            let cell: LocationCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(with: location)
            cell.accessibilityIdentifier = "locationCell\(indexPath.item)"
            cell.isAccessibilityElement = true
            return cell
        }
    }
    
    func setLocations(_ locations: [Location]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Location>()
        if !locations.isEmpty {
            snapshot.appendSections([Section.main])
            snapshot.appendItems(locations)
        }
        dataSource.apply(snapshot)
    }
}
