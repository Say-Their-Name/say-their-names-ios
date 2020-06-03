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
    
    private lazy var profileImageView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "man-in-red-jacket-1681010")
        imgV.contentMode = .scaleAspectFill
        //imgV.frame = CGRect(x: 0, y: 0, width: 160, height: 219)
        imgV.clipsToBounds = true
        imgV.translatesAutoresizingMaskIntoConstraints = false
        return imgV
    }()
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "GEORGE FLOYD"
        lbl.font = UIFont(name: "Karla-Bold", size: 13)
        lbl.textColor = UIColor.STN.primaryLabel
        lbl.lineBreakMode = .byTruncatingTail
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var dateOfIncidentLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "25.05.2020"
        lbl.font = UIFont(name: "Karla-regular", size: 13)
        lbl.textColor = UIColor.STN.secondaryLabel
        lbl.lineBreakMode = .byTruncatingTail
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.contentMode = .scaleAspectFill
        btn.setImage(UIImage(named: "bookmark"), for: .normal)
        btn.addTarget(self, action: #selector(didTapBookmark), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var labelsAndButtonContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
        
    // MARK:- Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .center
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with person: Person) {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        
        profileImageView.image = UIImage(named: "man-in-red-jacket-1681010")
        // ^Update to default place holder image when resource is added.
        // TO-DO: Use Kilo's ImageDownloader here to DL image
        nameLabel.text = person.fullName.uppercased()
        dateOfIncidentLabel.text = df.string(from: person.date) 
    }
    
    private func setUp() {
        labelsAndButtonContainer.addSubview(nameLabel)
        labelsAndButtonContainer.addSubview(dateOfIncidentLabel)
        labelsAndButtonContainer.addSubview(bookmarkButton)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: labelsAndButtonContainer.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: labelsAndButtonContainer.leadingAnchor),
            
            dateOfIncidentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateOfIncidentLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateOfIncidentLabel.bottomAnchor.constraint(equalTo: labelsAndButtonContainer.bottomAnchor, constant: -20),
            
            bookmarkButton.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: labelsAndButtonContainer.trailingAnchor)
        ])
        
        containerStack.addArrangedSubview(profileImageView)
        containerStack.addArrangedSubview(labelsAndButtonContainer)
        addSubview(containerStack)
        containerStack.fillSuperview()
    }

    // MARK:- Handlers
        
    @objc private func didTapBookmark() {
        // TODO: Implement BookMark Handler
    }
}
