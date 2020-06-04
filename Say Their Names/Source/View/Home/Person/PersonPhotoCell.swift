//
//  PersonPhotoCell.swift
//  Say Their Names
//
//  Created by Manase on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit
import Kingfisher

final class PersonPhotoCell: UICollectionViewCell {
    
    private let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        personImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(personImageView)
        personImageView.fillSuperview()
        personImageView.clipsToBounds = true
    }
    
    func setImage(withUrlString url: String) {
      personImageView.kf.indicatorType = .activity
      personImageView.kf.setImage(
        with: URL(string: url),
        placeholder: UIImage(named: "image-placeholder")
      )
    }
}

// MARK: Design Constants
extension PersonPhotoCell {
    private static var aspectRatio: CGFloat { 0.7 }
}

extension PersonPhotoCell {
    static func size(_ collectionView: UICollectionView) -> CGSize {
        let size = collectionView.bounds.size
        let width = size.height * aspectRatio
        return CGSize(width: width, height: size.height)
    }
}
