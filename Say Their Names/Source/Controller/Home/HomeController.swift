//
//  HomeController.swift
//  Say Their Names
//
//  Created by Franck-Stephane Ndame Mpouli on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

//MARK: - IDENTIFIERS
private let locationIdentifier = "locationCell"
private let peopleIdentifier = "PersonCell"
private let headerIdentifier = "PersonHeaderCell"
class HomeController: BaseViewController {
    
    
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var locationCollectionView: UICollectionView!
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    //MARK: - CONSTANTS
    private let searchBar = CustomSearchBar()
    private let locations = ["ALL", "MISSOURI", "TEXAS", "NEW YORK"] // dummy data
    
    //MARK: - ClASS METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        searchBar.setup(withController: self)
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Select first location by default
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        locationCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
    }
    
    fileprivate func setupCollectionView() {
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
        locationCollectionView.register(LocationCell.self, forCellWithReuseIdentifier: locationIdentifier)
        
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        peopleCollectionView.register(UINib(nibName: peopleIdentifier, bundle: nil), forCellWithReuseIdentifier: peopleIdentifier)
        peopleCollectionView.register(UINib(nibName: headerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    //MARK: - IBACTIONS
    @IBAction func searchButtonPressed(_ sender: Any) {
        UIImpactFeedbackGenerator().impactOccurred()
        searchBar.show()
    }
}

//MARK: - UICOLLECTIONVIEW EXTENSION
extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 0 ? locations.count : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView.tag == 0 { return UICollectionReusableView() }
        let headerView = peopleCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! PersonHeaderCell
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width - 32
        return collectionView.tag == 0 ? .zero : .init(width: width, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: locationIdentifier, for: indexPath) as! LocationCell
            if indexPath.item == 0 { cell.isSelected = true }
            cell.titleLabel.text = self.locations[indexPath.item]
            return cell
        } else {
            let cell = peopleCollectionView.dequeueReusableCell(withReuseIdentifier: peopleIdentifier, for: indexPath) as! PersonCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 24
        let locationCellSize = CGSize(width: 103, height: 36)
        let peopleCellSize = CGSize(width: width, height: 300)
        return collectionView.tag == 0 ? locationCellSize : peopleCellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            // Location CollectionView
            
        } else {
            // People CollectionView
            let personController = PersonController(service: self.service)
            present(personController, animated: true, completion: nil)
        }
    }
}
