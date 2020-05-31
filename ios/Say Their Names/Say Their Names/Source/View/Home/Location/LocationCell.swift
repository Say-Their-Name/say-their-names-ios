//
//  LocationCell.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class LocationCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.layer.borderColor = #colorLiteral(red: 0.06274509804, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
        titleLabel.layer.borderWidth = 1
    }

}
