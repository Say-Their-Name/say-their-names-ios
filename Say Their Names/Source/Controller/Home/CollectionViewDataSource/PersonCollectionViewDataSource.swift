//
//  PersonCollectionViewDataSource.swift
//  Say Their Names
//
//  Created by JohnAnthony on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonCollectionViewDataSource: NSObject {
     
    private var people: [Person]
    
    init(people: [Person] = []) {
        self.people = people 
    }
    
    func fetchPerson(at index: Int) -> Person {
        let person = people[index]
        return person
    }
    
    func setPeople(_ people: [Person]) {
        self.people = people
    }
    
    func appendPeople(_ people: [Person]) {
        self.people.append(contentsOf: people)
    }
    
}

extension PersonCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView.tag == 0 { return UICollectionReusableView() }
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PersonHeaderCell.headerIdentifier, for: indexPath) as! PersonHeaderCell
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        let person = people[indexPath.item]
        
        if let personCell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.personIdentifier, for: indexPath) as? PersonCell {
            personCell.configure(with: person)
            personCell.accessibilityIdentifier = "peopleCell\(indexPath.item)"
            personCell.isAccessibilityElement = true
            return personCell
        }
        
        return UICollectionViewCell()
    }
}
