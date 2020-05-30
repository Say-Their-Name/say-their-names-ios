//
//  HomeController.swift
//  Say Their Names
//
//  Created by Franck-Stephane Ndame Mpouli on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let navBar = CustomNavigationBar()
    @IBOutlet weak var locationCollectionView: UICollectionView!
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    
    private var categoriesIdentifier = "category"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .black

        let personController = PersonController(nibName: "PersonController", bundle: nil)
        personController.modalPresentationStyle = .fullScreen
        present(personController, animated: true, completion: nil)
        
        setupCategoriesCollectionView()
    }


    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent}
    
    func setupCategoriesCollectionView() {
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
        locationCollectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: categoriesIdentifier)
    }

}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: categoriesIdentifier, for: indexPath) as! CategoriesCell
        cell.titleLabel.text = "ALL"
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 103, height: 40)
    }
}
