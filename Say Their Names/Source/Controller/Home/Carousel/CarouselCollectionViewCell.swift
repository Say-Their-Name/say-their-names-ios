//
//  CarouselCollectionViewCell.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

protocol CollectionViewCellProtocol where Self: UICollectionViewCell {
    var reuseID: String {get}
    func setUp(with data: Any)
}

extension CollectionViewCellProtocol {

    var reuseID: String {
        self.reuseIdentifier ?? ""
    }
}

class CarouselCollectionViewCell: UICollectionViewCell, CollectionViewCellProtocol {

    // MARK: - Properties
    override var reuseIdentifier: String? {
        return "CarouselCollectionViewCell"
    }
    private var imageView: UIImageView!

    // MARK: - Methods
    func setUp(with data: Any) {
        //setup cell
        self.backgroundColor = .white
    }
}
