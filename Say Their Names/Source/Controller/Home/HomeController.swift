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
    private let locations = ["ALL", "MISSOURI", "TEXAS", "NEW YORK"] // dummy data

    //Carousel data
    private let carouselData = ["Data", "Data", "Data", "Data"] //dummy data
    private var carouselDataResultsHandler: ResultsDataHandler?
    
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
        // FIXME: can have multiple selected. need one source-of-truth here.
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
        peopleCollectionView.dataSource = self
        peopleCollectionView.register(UINib(nibName: peopleIdentifier, bundle: nil), forCellWithReuseIdentifier: peopleIdentifier)
        peopleCollectionView.register(CarouselHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
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
extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 0 ? locations.count : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView.tag == 0 { return UICollectionReusableView() }
        let headerView = peopleCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as! CarouselHeaderView
        carouselDataResultsHandler = ResultsDataHandler(resultsData: self.carouselData)
        headerView.resultsHandler = carouselDataResultsHandler
        headerView.configure()
        return headerView
    }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: locationIdentifier, for: indexPath) as! LocationCell
            if indexPath.item == 0 { cell.isSelected = true }
            cell.titleLabel.text = self.locations[indexPath.item]
            cell.accessibilityIdentifier = "locationCell\(indexPath.item)"
            cell.isAccessibilityElement = true
            return cell
        } else {
            let cell = peopleCollectionView.dequeueReusableCell(withReuseIdentifier: peopleIdentifier, for: indexPath) as! PersonCell
            cell.accessibilityIdentifier = "peopleCell\(indexPath.item)"
            cell.isAccessibilityElement = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView === locationCollectionView {
    
        }
        else if collectionView === peopleCollectionView {
            let width = collectionView.frame.width / 2 - 24
            return CGSize(width: width, height: 300)
        }
        else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === locationCollectionView {
            // nothing for now
        }
        else if collectionView === peopleCollectionView {
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
