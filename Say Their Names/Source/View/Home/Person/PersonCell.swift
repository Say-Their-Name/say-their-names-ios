//
//  PersonCell.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    static let personIdentifier = "personCell"

    @IBOutlet var personPhotoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with person: Person) {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        
        personPhotoImageView.image = UIImage(named: person.media.first ?? "man-in-red-jacket-1681010")
        // ^Update to default place holder image when resource is added.
        nameLabel.text = person.fullName
        dateLabel.text = df.string(from: person.date)
    }

}
