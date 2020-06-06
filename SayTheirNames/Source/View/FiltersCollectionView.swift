//
//  FiltersCollectionView.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class FiltersCollectionView: UICollectionView {
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInsetReference = .fromContentInset
        layout.sectionInset = Self.layoutInsets
        
        super.init(frame: .zero, collectionViewLayout: layout)
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupSelf() {
        backgroundColor = .systemBackground
    }
}

extension FiltersCollectionView {
    private static let layoutInsets = UIEdgeInsets(left: 16, right: 16)
}
