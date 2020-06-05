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

    typealias PersonCollectionViewDataSource = UICollectionViewDiffableDataSource<Section, SectionData>
    
    enum Section: Int, CaseIterable {
        case header
        case main
    }

    enum SectionData: Hashable {
        case person(Person)
        case header(HeaderCellContent)
    }

    private var shownSections: [Section] = []

    let dataSource: PersonCollectionViewDataSource

    var peopleHeaderCollectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        collectionView.register(cellType: PersonCell.self)
        collectionView.register(cellType: CarouselCollectionViewCell.self)
        
        self.dataSource =
            PersonCollectionViewDataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
                switch item {
                case .header(let headerData):
                    let cell: CarouselCollectionViewCell = collectionView.dequeueCell(for: indexPath)
                    cell.configure(with: headerData)
                    cell.accessibilityIdentifier = "headerCell\(indexPath.item)"
                    cell.isAccessibilityElement = true
                    return cell

                case .person(let person):
                    let cell: PersonCell = collectionView.dequeueCell(for: indexPath)
                    cell.configure(with: person)
                    cell.accessibilityIdentifier = "peopleCell\(indexPath.item)"
                    cell.isAccessibilityElement = true
                    return cell
                }
        }
    }
    
    func setPeople(_ people: [Person], headerData: [HeaderCellContent]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, SectionData>()
        snapShot.appendSections([.header])
        snapShot.appendItems(headerData.map({ SectionData.header($0) }))
        snapShot.appendSections([.main])
        snapShot.appendItems(people.map({ SectionData.person($0) }))
        dataSource.apply(snapShot)
    }
    
    func appendPeople(_ people: [Person]) {
        var snapshot = dataSource.snapshot()
        guard snapshot.sectionIdentifiers.contains(.main) else {
            print("Main section doesn't exist!!")
            return
        }
        snapshot.appendItems(people.map({ SectionData.person($0) }), toSection: .main)
        dataSource.apply(snapshot)
    }
    
    func person(at index: Int) -> Person? {
        let allMainItems = dataSource.snapshot().itemIdentifiers(inSection: Section.main)
        let index = allMainItems[index]
        switch index {
        case .person(let person):
            return person
        default:
            return nil
        }
    }

}
