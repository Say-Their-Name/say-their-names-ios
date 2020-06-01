//
//  PersonInfoViewController.swift
//  Say Their Names
//
//  Created by Manase on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class PersonDetailsController: UIViewController {

    @IBOutlet weak var mediaCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
        
        let personPhotoCell = UINib(nibName: "PersonPhotoCell", bundle: nil)
        mediaCollectionView.register(personPhotoCell, forCellWithReuseIdentifier: "PersonPhotoCell")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonPhotoCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PersonPhotoCell.size(collectionView)
    }
    
}
