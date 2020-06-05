//
//  PersonMediaCollectionViewCell.swift
//  Say Their Names
//
//  Created by Manase on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonMediaCollectionViewCell: UICollectionViewCell {
    
    lazy var mediaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "man-in-red-jacket-1681010")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    private func setupLayout() {
        mediaImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mediaImageView)
        contentView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            mediaImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            mediaImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mediaImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            mediaImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
}
