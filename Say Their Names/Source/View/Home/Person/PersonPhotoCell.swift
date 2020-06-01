//
//  PersonPhotoCell.swift
//  Say Their Names
//
//  Created by Manase on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonPhotoCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension PersonPhotoCell {
    static func size(_ collectionView: UICollectionView) -> CGSize {
        let size = collectionView.bounds.size
        let width = (size.height-24)-1
        return CGSize(width: width, height: size.height)
    }
}
