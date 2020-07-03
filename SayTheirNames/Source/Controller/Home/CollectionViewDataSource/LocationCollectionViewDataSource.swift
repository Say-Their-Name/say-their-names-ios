//
//  LocationCollectionViewDataSource.swift
//  SayTheirNames
//
//  Copyright (c) 2020 Say Their Names Team (https://github.com/Say-Their-Name)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

final class LocationCollectionViewDataSourceHelper {
    
    enum Section {
        case main
    }
    
    typealias LocationCollectionViewDataSource = UICollectionViewDiffableDataSource<Section, Location>
    
    let dataSource: LocationCollectionViewDataSource
    
    init(collectionView: UICollectionView) {
        collectionView.register(cellType: FilterCategoryCell.self)

        self.dataSource =
            LocationCollectionViewDataSource(collectionView: collectionView) { (collectionView, indexPath, location) -> UICollectionViewCell? in

            let cell: FilterCategoryCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(with: location)
            cell.accessibilityIdentifier = "locationCell\(indexPath.item)"
            cell.isAccessibilityElement = true
            let (index, total) = collectionView.displayableIndexAndTotal(fromIndexPath: indexPath, section: 0)
            let localizedLocation = location.name.capitalized(with: Locale.current)
            cell.accessibilityLabel = "\(localizedLocation), \(index) of \(total)"
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
