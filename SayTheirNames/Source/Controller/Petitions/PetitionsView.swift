//
//  PetitionsView.swift
//  Say Their Names
//
//  Copyright (c) 2020 Say Their Names Team (https://github.com/Say-Their-Name)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

final class PetitionsView: UIView {
        
    private lazy var navBarView = STNNavigationBar(
        title: Strings.petitions.uppercased()
    ).configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var collectionView = CallToActionCollectionView().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(cellType: CallToActionCell.self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSelf()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    /// Configures properties for the view itself
    private func setupSelf() {
        backgroundColor = UIColor.STN.black
    }
    
    /// Adds and configures constraints for subviews
    private func setupSubviews() {
        addSubview(navBarView)
        addSubview(collectionView)
        
        let safeGuide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            navBarView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: Self.navBarViewHeight),
            collectionView.topAnchor.constraint(equalTo: navBarView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor)
        ])
    }

    /// Binds a `CollectionViewManager` to the `collectionView`
    func bindPetitionManager(_ manager: PetitionsCollectionViewManager) {
        manager.configure(with: collectionView)
    }
}

// MARK: - Constants
extension PetitionsView {
    static let navBarViewHeight: CGFloat = 70
    static let filtersViewHeight: CGFloat = 70
}
