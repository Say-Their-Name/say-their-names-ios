//
//  PersonInfoViewController.swift
//  SayTheirNames
//
//  Created by Manase on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class PersonDetailsController: BaseViewController {

    @IBOutlet weak var mediaCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
        mediaCollectionView.register(cellType: PersonPhotoCell.self)
    }
    
    @IBAction func didPressBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didPressShare(_ sender: Any) {
    }
    
    @IBAction func didPressBookmark(_ sender: Any) {
    }
    
}

extension PersonDetailsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PersonPhotoCell = collectionView.dequeueCell(for: indexPath)
        let personImage = UIImage(named: "man-in-red-jacket-1681010")
        cell.setImage(personImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PersonPhotoCell.size(collectionView)
    }
}

// MARK: - Constants used in PersonDetailsController
private extension PersonDetailsController {
    var cellSpacing: CGFloat { 15 }
}
