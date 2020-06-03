//
//  HomeView.swift
//  Say Their Names
//
//  Created by Joseph A. Wardell on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class HomeView: UIView {

    var customNavBar: UIView!
    var locationCollectionView: UICollectionView!
    var peopleCollectionView: UICollectionView!

    required init?(coder: NSCoder) { fatalError("This should never be called") }
    override init(frame: CGRect) {

        customNavBar = UIView()
        
        let locationLayout = UICollectionViewFlowLayout()
        locationLayout.scrollDirection = .horizontal
        locationCollectionView = UICollectionView(frame: .zero, collectionViewLayout:locationLayout)
        
        let peopleLayout = UICollectionViewFlowLayout()
        peopleLayout.scrollDirection = .vertical
        peopleCollectionView = UICollectionView(frame: .zero, collectionViewLayout:peopleLayout)

        super.init(frame: frame)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        backgroundColor = .red
    }
}
