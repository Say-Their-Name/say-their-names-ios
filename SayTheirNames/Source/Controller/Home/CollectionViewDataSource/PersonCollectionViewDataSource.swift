//
//  PersonCollectionViewDataSource.swift
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

final class PersonCollectionViewDataSourceHelper {
    
    enum Section {
        case main
    }
    
    typealias PersonCollectionViewDataSource = UICollectionViewDiffableDataSource<Section, Person>
    
    let dataSource: PersonCollectionViewDataSource
    
    init(collectionView: UICollectionView) {
        collectionView.register(cellType: PersonCell.self)
        collectionView.registerNibForReusableSupplementaryView(reusableViewType: PersonHeaderCell.self,
                                                               forKind: UICollectionView.elementKindSectionHeader)
        
        self.dataSource =
            PersonCollectionViewDataSource(collectionView: collectionView) { (collectionView, indexPath, person) -> UICollectionViewCell? in
            let cell: PersonCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(with: person)
            cell.accessibilityIdentifier = "peopleCell\(indexPath.item)"
            cell.isAccessibilityElement = true
            return cell
        }
        
        self.dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            let header: PersonHeaderCell = collectionView.dequeueReusableSupplementaryView(forKind: kind, for: indexPath)
            return header
        }
    }
    
    func setPeople(_ people: [Person]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Person>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(people)
        dataSource.apply(snapshot)
    }
    
    func appendPeople(_ people: [Person]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(people)
        dataSource.apply(snapshot)
    }
    
    func person(at index: Int) -> Person {
        let people = dataSource.snapshot().itemIdentifiers(inSection: Section.main)
        return people[index] // TODO: check index
    }
}
