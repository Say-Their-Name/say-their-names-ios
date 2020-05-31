//
//  DonationsController.swift
//  Say Their Names
//
//  Created by Franck-Stephane Ndame Mpouli on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

<<<<<<< HEAD:ios/Say Their Names/Say Their Names/Source/Controller/Donations/DonationsController.swift
class DonationsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
=======
class HomeController: UIViewController {
    
    let navBar = CustomNavigationBar()
    @IBOutlet weak var locationCollectionView: UICollectionView!
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    
    private let locationIdentifier = "locationCell"
    private let peopleIdentifier = "personCell"
    private let headerIdentifier = "personHeaderCell"
    
    private let locations = ["ALL", "MISSOURI", "TEXAS", "NEW YORK"]
    
    private var selectedLocation = "ALL"
    private var lastCell: LocationCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        
        setupLocationCollectionView()
        setupPeopleCollectionView()
    }
    
    func setupLocationCollectionView() {
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
        locationCollectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "none")
        locationCollectionView.register(UINib(nibName: "LocationCell", bundle: nil), forCellWithReuseIdentifier: locationIdentifier)
    }
    
    func setupPeopleCollectionView() {
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = self
        peopleCollectionView.register(UINib(nibName: "PersonCell", bundle: nil), forCellWithReuseIdentifier: peopleIdentifier)
        peopleCollectionView.register(UINib(nibName: "PersonHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
>>>>>>> implement tabBar and home collection views:ios/Say Their Names/Say Their Names/Controller/Home/HomeController.swift
    }

}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == locationCollectionView ? locations.count : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == peopleCollectionView {
            let headerView = peopleCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! PersonHeaderCell
            return headerView
        } else {
            return locationCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "none", for: indexPath)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return collectionView == peopleCollectionView ? .init(width: peopleCollectionView.frame.width - 32, height: 150) : .init(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == locationCollectionView {
            let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: locationIdentifier, for: indexPath) as! LocationCell
            cell.titleLabel.text = self.locations[indexPath.row]
            return cell
        } else {
            let cell = peopleCollectionView.dequeueReusableCell(withReuseIdentifier: peopleIdentifier, for: indexPath) as! PersonCell
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == locationCollectionView ? .init(width: 103, height: 36) : .init(width: 165, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == peopleCollectionView {
            let personController = PersonController(nibName: "PersonController", bundle: nil)
            present(personController, animated: true, completion: nil)
        } else {
            
            let cell = locationCollectionView.cellForItem(at: indexPath) as! LocationCell
            selectedLocation = locations[indexPath.row]
            
            cell.backgroundColor = #colorLiteral(red: 0.07726221532, green: 0.07726515085, blue: 0.07726357132, alpha: 1)
            cell.titleLabel.textColor = .white
            
            self.lastCell?.backgroundColor = .white
            self.lastCell?.titleLabel.textColor = #colorLiteral(red: 0.07726221532, green: 0.07726515085, blue: 0.07726357132, alpha: 1)
            self.lastCell = cell
        
        }
    }
}
