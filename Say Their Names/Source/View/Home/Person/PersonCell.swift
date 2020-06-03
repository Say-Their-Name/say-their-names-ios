//
//  PersonCell.swift
//  Say Their Names
//
//  Created by Ahmad Karkouti on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class PersonCell: UICollectionViewCell {
    static let personIdentifier = "personCell"
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var profileImageView: UIImageView!
    @IBOutlet weak private var birthdayLabel: UILabel!
    @IBOutlet weak private var bookmarkButton: UIButton!
        
    // MARK:- Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with person: Person) {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        
        profileImageView.image = #imageLiteral(resourceName: "man-in-red-jacket-1681010")
        // ^Update to default place holder image when resource is added.
        // TO-DO: Use Kilo's ImageDownloader here to DL image
        nameLabel.text = person.fullName
        birthdayLabel.text = df.string(from: person.date) // TODO: this is NOT a birthday, but incident date
    }

    // MARK:- Handlers
        
    @IBAction private func bookmark(_ sender: UIButton) {
        // TODO: Implement BookMark Handler
    }
}
