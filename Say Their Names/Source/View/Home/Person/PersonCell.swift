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
        
        personPhotoImageView.image = #imageLiteral(resourceName: "man-in-red-jacket-1681010")
        // ^Update to default place holder image when resource is added.
        // TO-DO: Use Kilo's ImageDownloader here to DL image
        nameLabel.text = person.fullName
        dateLabel.text = df.string(from: person.date)
    }

}
