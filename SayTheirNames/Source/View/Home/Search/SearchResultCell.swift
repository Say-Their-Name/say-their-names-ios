//
//  SearchResultCell.swift
//  SayTheirNames
//
//  Created by Ahmad Karkouti on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    private let separatorView = UIView()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    
    var isSeperatorViewHidden: Bool? {
        didSet {
            guard let isSeperatorViewHidden  = isSeperatorViewHidden else {return}
            separatorView.isHidden = isSeperatorViewHidden
        }
    }
    
    var data: Person? {
        didSet {
//            guard let data  = data else {return}
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorView.anchor(
            superView: self,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(left: 16, right: 16),
            size: .init(width: 0, height: 1))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
