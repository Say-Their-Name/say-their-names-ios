//
//  CollectionViewDataSource.swift
//  Say Their Names
//
//  Created by JohnAnthony on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class CollectionViewDataSource<Model>: NSObject, UICollectionViewDataSource {
    // typealias CellConfigurator = (T, UICollectionViewCell) -> ()
    
    var models: [Model]
    
    private let reuseIdentifier: String
    // private let cellConfigurator: CellConfigurator
    
    init(models: [Model],
         reuseIdentifier: String/*,
         cellConfigurator: @escaping CellConfigurator*/) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        // self.cellConfigurator = cellConfigurator
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // let model = models[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // cellConfigurator(model, cell)
        
        return cell
    }
}

extension CollectionViewDataSource where Model == Person {
    static func make(for people: [Person],
                     reuseIdentifier: String = "person") -> CollectionViewDataSource {
        return CollectionViewDataSource(models: people,
                                        reuseIdentifier: reuseIdentifier) /*{
           // cell configuration as trailing closure to go here when implemented.
        }*/
    }
}
