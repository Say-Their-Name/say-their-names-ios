//
//  HomeController.swift
//  Say Their Names
//
//  Created by Franck-Stephane Ndame Mpouli on 30/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

//MARK: - IDENTIFIERS
private let headerIdentifier = "PersonHeaderCell"
private let peopleIdentifier = "PersonCell"

class HomeController: UIViewController, ServiceReferring {
        
    let service: Service?
    
    required init(service: Service) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - CONSTANTS
    private let searchBar = CustomSearchBar()
    
    //MARK: - CV Data Sources
    private let locationsDataSource = LocationCollectionViewDataSource(locations: [])
    private let peopleDataSource = PersonCollectionViewDataSource()
    
    private let homeView = HomeView()
    var customNavBar : UIView { homeView.customNavigationBar }
    var locationCollectionView : UICollectionView { homeView.locationCollectionView }
    var peopleCollectionView : UICollectionView { homeView.peopleCollectionView }
    var searchButton : UIButton { homeView.searchButton }
    
    
    //MARK: - ClASS METHODS

    override func loadView() {
        self.view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        searchBar.setup(withController: self)
        setupCollectionView()
        setupSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Select first location by default
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        locationCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
    }

    private func setupSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonPressed(_:)), for: .touchUpInside)
    }
    
    fileprivate func setupCollectionView() {
        
        // TO-DO: Dummy data for now, should update after API call to get locations
        let locations: [Location] = [.init(name: "ALL"),
                         .init(name: "RECENT"),
                         .init(name: "MISSOURI"),
                         .init(name: "TEXAS"),
                         .init(name: "NEW YORK")]
        
        var people: [Person] = []
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        for i in 0..<10 {
            people.append(Person(
                id: "id\(i)",
                fullName: "George Floyd \(i)",
                age: i,
                childrenCount: i,
                date: df.date(from: "25.05.2020") ?? Date(),
                location: "",
                media: ["man-in-red-jacket-1681010"],
                bio: "",
                context: "",
                donations: [],
                petitions: []))
        }
        
        locationsDataSource.setLocations(locations)
        peopleDataSource.setPeople(people)
        
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = locationsDataSource
        locationCollectionView.register(LocationCell.self, forCellWithReuseIdentifier: LocationCell.locationIdentifier)
        locationCollectionView.isAccessibilityElement = false
        locationCollectionView.accessibilityIdentifier = "locationCollection"
        
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = peopleDataSource
        peopleCollectionView.register(UINib(nibName: peopleIdentifier, bundle: nil), forCellWithReuseIdentifier: PersonCell.personIdentifier)
        peopleCollectionView.register(UINib(nibName: headerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        peopleCollectionView.accessibilityIdentifier = "peopleCollection"
        peopleCollectionView.isAccessibilityElement = false
    }
    
    //MARK: - IBACTIONS
    @IBAction func searchButtonPressed(_ sender: Any) {
        UIImpactFeedbackGenerator().impactOccurred()
        searchBar.show()
    }
}

//MARK: - UICOLLECTIONVIEW EXTENSION
extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width - 32
        return collectionView.tag == 0 ? .zero : .init(width: width, height: 170)
    }
//<<<<<<< HEAD
//
//=======
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView.tag == 0 {
//            let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: locationIdentifier, for: indexPath) as! LocationCell
//            if indexPath.item == 0 { cell.isSelected = true }
//            cell.titleLabel.text = self.locations[indexPath.item]
//            cell.accessibilityIdentifier = "locationCell\(indexPath.item)"
//            cell.isAccessibilityElement = true
//            return cell
//        } else {
//            let cell = peopleCollectionView.dequeueReusableCell(withReuseIdentifier: peopleIdentifier, for: indexPath) as! PersonCell
//            cell.accessibilityIdentifier = "peopleCell\(indexPath.item)"
//            cell.isAccessibilityElement = true
//            return cell
//        }
//    }
//
//>>>>>>> development
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
            guard let service = self.service else { return }
            
            // People CollectionView
            // let selectedPerson = peopleDataSource.fetchPerson(at: indexPath.item)
            let personController = PersonController(service: service)
            
            let navigationController = UINavigationController(rootViewController: personController)
            navigationController.navigationBar.isHidden = true
            present(navigationController, animated: true, completion: nil)
        }
    }
}
