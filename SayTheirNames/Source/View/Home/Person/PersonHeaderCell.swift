//
//  PersonHeaderCell.swift
//  SayTheirNames
//
//  Created by Ahmad Karkouti on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonHeaderCell: UICollectionViewCell {
    static let headerIdentifier = "PersonHeaderCell"
    @IBOutlet weak var howToGetInvolvedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupLocalizedStrings()
    }
    
    private func setupLocalizedStrings() {
        if let howToGetInvolved = NSLocalizedString("How_to_get_involved", comment: "How To Get Involved") as String? {
            self.howToGetInvolvedLabel.text = howToGetInvolved
        } else {
            self.howToGetInvolvedLabel.text = "How to get involved"
        }
    }

}
