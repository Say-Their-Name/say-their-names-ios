//
//  CollectionViewDataSource.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class CollectionViewDataSource<T: CollectionViewCellProtocol>: NSObject, UICollectionViewDataSource, DataHandlerProtocol {

    // MARK: - Properties
    var resultsHandler: ResultsDataHandler
    var reuseId: String

    var resultsData: [Any]? {
        return resultsHandler.retriveDataFromHandeler()
    }

    init(resultsHandler: ResultsDataHandler, reuseId: String) {
        self.resultsHandler = resultsHandler
        self.reuseId = reuseId
    }

    // MARK: - Methods
    // MARK: - Collection view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let results = resultsData else {return 0}
        return results.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // do something with a delegate
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseId, for: indexPath) as? T else {return UICollectionViewCell()}
        guard let object = resultsData?[indexPath.row] else {return UICollectionViewCell()}
        cell.setUp(with: object)
        return cell
    }

}

