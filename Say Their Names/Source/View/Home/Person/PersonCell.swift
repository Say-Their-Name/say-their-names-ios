//
//  PersonCell.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class PersonCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var data: Person? {
        didSet {
            //guard let data  = data else {return}
        }
    }
    
    // MARK:- Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK:- Handlers
        
    @IBAction private func bookmark(_ sender: UIButton) {
        // TODO: Implement BookMark Handler
    }
}
