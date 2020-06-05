//
//  PersonHeaderView.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class PersonHeaderView: UICollectionReusableView {

    typealias PersonHeaderViewCollectionViewDataSource = UICollectionViewDiffableDataSource<HeaderSection, HeaderCellContent>

    // MARK: - Properties
    var pageControl: LineCarouselControl?
    var collectionView: UICollectionView!
    var headerDataSource: PersonHeaderViewCollectionViewDataSource!

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .yellow
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func configure() {
        setUpCollectionView()
        setUpPagingController()
        setUpView()
    }

    private func setUpCollectionView() {
        registerCells()
        setUpDataSource()
        collectionView?.delegate = self
    }

    private func setUpDataSource() {
        self.headerDataSource =
            PersonHeaderViewCollectionViewDataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
                let cell: CarouselCollectionViewCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(with: item)
                return cell
        }
        collectionView?.dataSource = headerDataSource
    }

    private func registerCells() {
        collectionView?.register(cellType: CarouselCollectionViewCell.self)
    }

    private func setUpPagingController() {
        pageControl = LineCarouselControl()
        pageControl?.delegate = self
        print(headerDataSource.snapshot().numberOfItems)
        pageControl?.numberOfPages = 3
    }

    private func setUpView() {
        guard let collectionView = collectionView,
              let _ = pageControl else {return}
        self.add(collectionView) {
            $0.anchor(top: topAnchor,
                      leading: leadingAnchor,
                      bottom: bottomAnchor,
                      trailing: trailingAnchor,
                      padding: .init(top: 0,
                                     left: 0,
                                     bottom: 0,
                                     right: 0))
        }
        //leaving this in here until we find a fix for the horizontal scrolling.
//        self.add(pageControl) {
//            $0.delegate = self
//            $0.backgroundColor = .red
//            $0.anchor(top: collectionView.bottomAnchor,
//                      leading: collectionView.leadingAnchor,
//                      bottom: bottomAnchor,
//                      trailing: collectionView.trailingAnchor,
//                      padding: .init(top: 0,
//                                     left: 0,
//                                     bottom: 0,
//                                     right: 0),
//                        size: .init(width: bounds.width,
//                                    height: 0))
//        }
    }

}

// MARK: - Collection view delegate
extension PersonHeaderView: UICollectionViewDelegate, UIScrollViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: do something here later on with the cells content
        print("*** selected \(indexPath.row)")
    }

    // MARK: - Scroll view delegates
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView,
              let pageControl = pageControl else {return}
        let centerX = collectionView.center.x + collectionView.contentOffset.x
        let centerY = collectionView.center.y + collectionView.contentOffset.y
        guard let indexPath = collectionView.indexPathForItem(at: .init(x: centerX, y: centerY)) else {return}
        pageControl.currentPage = indexPath.item
    }

}

// MARK: - Line carousel delegate
extension PersonHeaderView: LineCarouselControlProtocol {

    func didSelectLineAt(_ index: Int) {
        guard let collectionView = collectionView else {return}
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }

}
