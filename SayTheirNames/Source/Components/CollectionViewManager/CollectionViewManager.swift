//
//  CollectionViewManager.swift
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

/// Responsible for handling updates to a `UICollectionView`'s DataSource
class CollectionViewManager<Section: Hashable, Item: Hashable>: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    /// Callback that is responsible for configuring the `UICollectionViewCell`
    /// ~~~
    /// manager.cellForItem = { (collectionView, indexPath, item) -> UICollectionViewCell? in
    ///   // Configure and return cell
    /// }
    /// ~~~
    var cellForItem: UICollectionViewDiffableDataSource<Section, Item>.CellProvider?
    
    /// Callback that returns the selected item
    var didSelectItem: ((Item) -> Void)?
    
    /// Callback that returns the collectionView and the indexPath of the cell to be displayed
    var willDisplayCell: ((_ collectionView: UICollectionView, _ forItemAt: IndexPath) -> Void)?
    
    /// Collection view tied to the DataSource
    private var collectionView: UICollectionView?
    /// Diffable DataSource responsible for managing snapshots
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    /// Binds the `UICollectionView` to the DataSource and delegate
    func configure(with collectionView: UICollectionView) {
        collectionView.delegate = self
        self.collectionView = collectionView
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { [weak self] in
            self?.cellForItem?($0, $1, $2)
        }
    }
    
    /// Updates the items in the specified section
    func set(_ items: [Item], in section: Section) {
        applyChange { snapshot in
            snapshot.appendSections([section])
            snapshot.appendItems(items)
        }
    }
    
    /// Updates the snapshot items with new items
    func append(_ items: [Item], in section: Section) {
        guard var snapshot = dataSource?.snapshot() else { return }
        snapshot.appendItems(items, toSection: section)
        dataSource?.apply(snapshot)
    }
    
    /// Removes all items from the DataSource
    func removeAll() {
        applyChange { snapshot in
            snapshot.deleteAllItems()
        }
    }
    
    /// Convience function for creating a snapshot and applying changes
    private func applyChange(change: (inout NSDiffableDataSourceSnapshot<Section, Item>) -> Void) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        change(&snapshot)
        dataSource?.apply(snapshot)
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
        didSelectItem?(item)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let size = flowLayout.flatMap { $0.estimatedItemSize } ?? .zero
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplayCell?(collectionView, indexPath)
    }
}

extension CollectionViewManager where Section == SingleSection {
    /// Updates the items in the main section
    func set(_ items: [Item]) {
        applyChange { snapshot in
            snapshot.appendSections([.main])
            snapshot.appendItems(items)
        }
    }
}

extension CollectionViewManager {
    func section(at index: Int) -> Section? {
        let allSections = dataSource?.snapshot().sectionIdentifiers
        return allSections?[index]
    }
}
