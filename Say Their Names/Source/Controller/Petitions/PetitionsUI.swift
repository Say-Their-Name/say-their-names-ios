//
//  PetitionsUI.swift
//  Say Their Names
//
//  Created by Kyle Lee on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// The UI for Petitions
final class PetitionsUI: UICollectionView {
    
    init() {
        super.init(frame: .zero, collectionViewLayout: .init())
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    /// Configures properties for the view itself
    private func setupSelf() {
        backgroundColor = .systemBackground
    }
    
    /// Adds and configures constraints for subviews
    private func setupSubviews() {
        
    }
}
