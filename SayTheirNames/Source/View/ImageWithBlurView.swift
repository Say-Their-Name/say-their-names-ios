//
//  ImageWithBlurView.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/5/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class ImageWithBlurView: UIView {
    // MARK: - View
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
        imageView.frame = superview?.bounds ?? CGRect.zero
        imageView.image = UIImage(named: "man-in-red-jacket-1681010")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var frontImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = frontImageContainerView.bounds
        imageView.image = UIImage(named: "man-in-red-jacket-1681010")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Subview
    private func configureView() {
        addSubview(bgImageView)
        frontImageContainerView.addSubview(frontImageView)
        visualEffectView.contentView.addSubview(frontImageContainerView)
        addSubview(visualEffectView)

        bgImageView.fillSuperview(superView: self, padding: .zero)
        visualEffectView.fillSuperview(superView: self, padding: .zero)
        frontImageView.fillSuperview(superView: frontImageContainerView, padding: .zero)
   
        // Layout Constraints
        frontImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            bgImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            bgImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            bgImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

            visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            visualEffectView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),

            frontImageView.leadingAnchor.constraint(equalTo: frontImageContainerView.leadingAnchor, constant: 0),
            frontImageView.trailingAnchor.constraint(equalTo: frontImageContainerView.trailingAnchor, constant: 0),
            frontImageView.topAnchor.constraint(equalTo: frontImageContainerView.topAnchor, constant: 0),
            frontImageView.bottomAnchor.constraint(equalTo: frontImageContainerView.bottomAnchor, constant: 0),
            
            frontImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            frontImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            frontImageContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            frontImageContainerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            frontImageContainerView.heightAnchor.constraint(equalToConstant: 390),
        ])
    }
    
    // MARK: - Method
    public func setup(_ person: Person) {
        frontImageView.populate(withURL: person.images[0].personURL)
        bgImageView.populate(withURL: person.images[0].personURL)
    }
}
