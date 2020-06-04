//
//  CauroselHeaderView.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class CarouselHeaderView: UICollectionReusableView, Reusable {

    // MARK: - Properties
    var pageControl: LineCarouselControl?
    var collectionView: UICollectionView?
    var collectionViewDataSource: CollectionViewDataSource<CarouselCollectionViewCell>?
    //TODO:- change this type to the model type that will be used instead
    var resultsHandler: ResultsDataHandler<String>?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: createFlowLayout())
        registerCells()
        setUpDataSource()
        guard let dataSource = collectionViewDataSource else {return}
        collectionView?.dataSource = dataSource
        collectionView?.delegate = self
    }

    private func setUpDataSource() {
        guard let handler = resultsHandler else {return}
        collectionViewDataSource = CollectionViewDataSource(resultsHandler: handler)
    }

    private func registerCells() {
        collectionView?.register(cellType: CarouselCollectionViewCell.self)
    }

    private func setUpPagingController() {
        guard let dataSource = collectionViewDataSource?.resultsData else {return}
        pageControl = LineCarouselControl()
        pageControl?.numberOfPages = dataSource.count
    }

    private func setUpView() {
        guard let collectionView = collectionView,
              let pageControl = pageControl else {return}
        self.add(collectionView) {
            $0.backgroundColor = .white
            $0.anchor(top: topAnchor,
                      leading: leadingAnchor,
                      bottom: bottomAnchor,
                      trailing: trailingAnchor,
                      padding: .init(top: 0,
                                     left: 0,
                                     bottom: 20,
                                     right: 0))
        }
        self.add(pageControl) {
            $0.delegate = self
            $0.anchor(top: collectionView.bottomAnchor,
                      leading: collectionView.leadingAnchor,
                      bottom: bottomAnchor,
                      trailing: collectionView.trailingAnchor,
                      padding: .init(top: 10,
                                     left: 0,
                                     bottom: 0,
                                     right: 0),
                        size: .init(width: bounds.width,
                                    height: 20))
        }
    }

    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }

}

// MARK: - Collection view delegate
extension CarouselHeaderView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: do something here later on with the cells content
        print("*** selected \(indexPath.row)")
    }

    // MARK: - Scroll view delegates
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView,
              let pageControl = pageControl else {return}
        collectionView.scrollToNearestVisibleCollectionViewCell()
        let centerX = collectionView.center.x + collectionView.contentOffset.x
        let centerY = collectionView.center.y + collectionView.contentOffset.y
        guard let indexPath = collectionView.indexPathForItem(at: .init(x: centerX, y: centerY)) else {return}
        pageControl.currentPage = indexPath.item
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.collectionView?.scrollToNearestVisibleCollectionViewCell()
        }
    }
}

// MARK: - Collection view flow layout
extension CarouselHeaderView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.bounds.width - 20, height: collectionView.bounds.height)
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 3
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
       }


}

// MARK: - Line carousel delegate
extension CarouselHeaderView: LineCarouselControlProtocol {

    func didSelectLineAt(_ index: Int) {
        guard let collectionView = collectionView else {return}
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    }

}
