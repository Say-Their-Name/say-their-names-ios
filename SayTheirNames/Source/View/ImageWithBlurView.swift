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
        view.backgroundColor = UIColor.STN.yellow
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

        // Layout Constraints
        bgImageView.fillSuperview(superView: self, padding: .zero)
        visualEffectView.fillSuperview(superView: self, padding: .zero)
        frontImageView.fillSuperview(superView: frontImageContainerView, padding: .zero)
        frontImageContainerView.fillSuperview(superView: self, padding: .init(top: 32, left: 40, bottom: 32, right: 40))
    }
    
    // MARK: - Method
    public func setup(_ person: Person) {
        guard person.images.first != nil else { return }
        frontImageView.populate(withURL: person.images[0].personURL)
        bgImageView.populate(withURL: person.images[0].personURL)
    }
}
