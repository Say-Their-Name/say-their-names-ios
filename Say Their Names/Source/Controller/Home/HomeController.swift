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

class HomeController: BaseViewController {
        
    var launchScreen: LaunchScreen?
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var locationCollectionView: UICollectionView!
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    //MARK: - CONSTANTS
    private let searchBar = CustomSearchBar()
    
    //MARK: - CV Data Sources
    private let locationsDataSource = LocationCollectionViewDataSource(locations: [])
    private let peopleDataSource = PersonCollectionViewDataSource()
    
    //MARK: - ClASS METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
        searchBar.setup(withController: self)
        setupCollectionView()
        showLaunchScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Select first location by default
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        locationCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // To-Do: move this logic to after data is fetched from back-end
        removeLaunchScreen()
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
        
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = peopleDataSource
        peopleCollectionView.register(UINib(nibName: peopleIdentifier, bundle: nil), forCellWithReuseIdentifier: PersonCell.personIdentifier)
        peopleCollectionView.register(UINib(nibName: headerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
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
            let navigationController = UINavigationController(rootViewController: personController)
            navigationController.navigationBar.isHidden = true
            present(navigationController, animated: true, completion: nil)
        }
    }
}

// MARK - Launch screen
extension HomeController {
    private func showLaunchScreen() {
        let bundle = Bundle(for: LaunchScreen.self)
        if let launch = bundle.loadNibNamed("LaunchScreen", owner: self, options: nil)?.first as? LaunchScreen {
            hideTabBar()
            view.addSubview(launch)
            launch.frame = view.bounds
            launchScreen = launch
        }
    }

    private func removeLaunchScreen() {
        guard let launchScreen = launchScreen else { return }

        let completion = {
            self.revealTabBar()
        }
        launchScreen.animate(completion: completion)
    }
}
