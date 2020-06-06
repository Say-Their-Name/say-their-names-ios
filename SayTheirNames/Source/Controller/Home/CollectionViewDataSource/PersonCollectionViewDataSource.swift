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
