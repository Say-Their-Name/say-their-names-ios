//
//  PersonPhotoTableViewCell.swift
//  Say Their Names
//
//  Created by Manase on 04/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static func register(to tableView: UITableView, identifier: String) {
        tableView.register(Self.self, forCellReuseIdentifier: identifier)
    }
}

class PersonPhotoTableViewCell: UITableViewCell {

    lazy var visualEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: effect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    lazy var frontImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.clipsToBounds = true
        return view
    }()
    
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.superview?.bounds ?? CGRect.zero
        imageView.image = UIImage(named: "man-in-red-jacket-1681010")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var frontImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.frontImageContainerView.bounds
        imageView.image = UIImage(named: "man-in-red-jacket-1681010")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .red
        contentView.clipsToBounds = true
        
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        frontImageView.translatesAutoresizingMaskIntoConstraints = false
        frontImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(bgImageView)
        frontImageContainerView.addSubview(frontImageView)
        visualEffectView.contentView.addSubview(frontImageContainerView)

        contentView.addSubview(visualEffectView)

        NSLayoutConstraint.activate([
            bgImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            bgImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            bgImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            bgImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            visualEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            visualEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            visualEffectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            visualEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),

            frontImageView.leadingAnchor.constraint(equalTo: frontImageContainerView.leadingAnchor, constant: 0),
            frontImageView.trailingAnchor.constraint(equalTo: frontImageContainerView.trailingAnchor, constant: 0),
            frontImageView.topAnchor.constraint(equalTo: frontImageContainerView.topAnchor, constant: 0),
            frontImageView.bottomAnchor.constraint(equalTo: frontImageContainerView.bottomAnchor, constant: 0),
            
            frontImageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            frontImageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            frontImageContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            frontImageContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            frontImageContainerView.heightAnchor.constraint(equalToConstant: 390),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
