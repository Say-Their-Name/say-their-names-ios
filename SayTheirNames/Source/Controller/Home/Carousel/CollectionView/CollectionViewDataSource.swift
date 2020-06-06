//
//  CollectionViewDataSource.swift
//  Say Their Names
//
//  Created by Thomas Murray on 06/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class CollectionViewDataSource<Cell: CollectionViewCellProtocol>: NSObject, UICollectionViewDataSource, DataHandlerProtocol {

    // MARK: - Properties
    var resultsHandler: ResultsDataHandler<String>

    var resultsData: [Any]? {
        return resultsHandler.retriveDataFromHandeler()
    }

    init(resultsHandler: ResultsDataHandler<String>) {
        self.resultsHandler = resultsHandler
    }

    // MARK: - Methods
    // MARK: - Collection view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let results = resultsData else {return 0}
        return results.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // do something with a delegate
        let cell: Cell = collectionView.dequeueCell(for: indexPath)
        guard let object = resultsData?[indexPath.row] else {return UICollectionViewCell()}
        cell.setUp(with: object)
        return cell
    }

}
