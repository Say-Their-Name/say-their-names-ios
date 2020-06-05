//
//  PersonCollectionViewDataSource.swift
//  SayTheirNames
//
//  Created by JohnAnthony on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

enum HeaderSection {
    case main
}

final class PersonCollectionViewDataSourceHelper {
    
    enum Section {
        case main
    }

    typealias PersonCollectionViewDataSource = UICollectionViewDiffableDataSource<Section, Person>

    let dataSource: PersonCollectionViewDataSource

    var personHeaderView: PersonHeaderView?

    var peopleHeaderCollectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        collectionView.register(cellType: PersonCell.self)
        collectionView.registerHeader(headerType: PersonHeaderView.self)
        
        self.dataSource =
            PersonCollectionViewDataSource(collectionView: collectionView) { (collectionView, indexPath, person) -> UICollectionViewCell? in
                let cell: PersonCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(with: person)
                cell.accessibilityIdentifier = "peopleCell\(indexPath.item)"
                cell.isAccessibilityElement = true
                return cell
        }

        self.dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            let header: PersonHeaderView = collectionView.dequeueReusableSupplementaryView(forKind: kind, for: indexPath)
            header.collectionView = self.peopleHeaderCollectionView
            self.personHeaderView = header
            return header
        }
    }

    func setHeaderData(_ data: [HeaderCellContent]) {
        personHeaderView?.configure()
        var snapShot = NSDiffableDataSourceSnapshot<HeaderSection, HeaderCellContent>()
        snapShot.appendSections([HeaderSection.main])
        snapShot.appendItems(data)
        personHeaderView?.headerDataSource.apply(snapShot)
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
