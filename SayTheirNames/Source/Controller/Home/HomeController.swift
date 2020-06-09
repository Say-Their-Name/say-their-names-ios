//
//  HomeController.swift
//  SayTheirNames
//
//  Copyright (c) 2020 Say Their Names Team (https://github.com/Say-Their-Name)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

// MARK: - IDENTIFIERS
private let headerIdentifier = "PersonHeaderCell"
private let peopleIdentifier = "PersonCell"

final class HomeController: UIViewController {
    @DependencyInject private var network: NetworkRequestor
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - CONSTANTS
    private let searchBar = CustomSearchBar()
    
    // MARK: - CV Data Sources
    private lazy var locationsDataSourceHelper = LocationCollectionViewDataSourceHelper(collectionView: locationCollectionView)
    private lazy var peopleDataSourceHelper = PersonCollectionViewDataSourceHelper(collectionView: peopleCollectionView)
    
    private lazy var homeView = HomeView()
        
    private var locationCollectionView: UICollectionView { homeView.locationCollectionView }
    private var peopleCollectionView: UICollectionView { homeView.peopleCollectionView }    
    
    // MARK: - ClASS METHODS
    override func loadView() {
        self.view = homeView
        homeView.peopleDataSource = peopleDataSourceHelper
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(asset: STNAsset.Color.black)
        searchBar.setup(withController: self)
        navigationItem.title = Strings.home
        setupCollectionView()
        setupSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Select first location by default
        // FIXME: can have multiple selected. need one source-of-truth here.
        guard FeatureFlags.filtersEnabled else { return }
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        locationCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupSearchButton() {
        let searchImage = UIImage(asset: STNAsset.Image.searchWhite)?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: searchImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(searchButtonPressed(_:)))
    }
    
    fileprivate func setupCollectionView() {

        let carouselData: [HeaderCellContent] = [
            .init(title: "#BLACKLIVESMATTER", description: "How to get involved"),
            .init(title: "#BLACKLIVESMATTER", description: "How to get involved"),
            .init(title: "#BLACKLIVESMATTER", description: "How to get involved")
        ]
        
        // TO-DO: Dummy data for now, should update after API call to get locations
        let locations: [Location] = [.init(name: "ALL"),
                         .init(name: "RECENT"),
                         .init(name: "MISSOURI"),
                         .init(name: "TEXAS"),
                         .init(name: "NEW YORK")]

        locationsDataSourceHelper.setLocations(locations)
        
        // FIXME: This should be setup in a better place, for now this loads out data
        self.network.fetchPeople { [weak self] (result) in
            switch result {
            case .success(let page):
                self?.peopleDataSourceHelper.setPeople(page.all, carouselData: carouselData)
                self?.peopleCollectionView.reloadData()
            case .failure(let error):
                Log.print(error)
            }
        }

        locationCollectionView.delegate = self
        locationCollectionView.dataSource = locationsDataSourceHelper.dataSource
        locationCollectionView.accessibilityIdentifier = "locationCollection"
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = peopleDataSourceHelper.dataSource
        peopleCollectionView.accessibilityIdentifier = "peopleCollection"
    }
    
    // MARK: - Button Actions
    @objc private func searchButtonPressed(_ sender: Any) {
        UIImpactFeedbackGenerator().impactOccurred()
        searchBar.show()
    }
    
    private func showPersonDetails(withPerson: Person) {
        let personController = PersonController()
        personController.person = withPerson
        
        let navigationController = UINavigationController(rootViewController: personController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - UICOLLECTIONVIEW EXTENSION
extension HomeController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === locationCollectionView {
            return Theme.Screens.Home.CellSize.location
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
            // People CollectionView
            
            guard let selectedPerson = peopleDataSourceHelper.person(at: indexPath.item) else { return }
            self.showPersonDetails(withPerson: selectedPerson)
        }
    }
}

extension HomeController: DeepLinkHandle {
    func handle(deepLink: DeepLink) {
        guard let deepLink = deepLink as? PersonDeepLink else { return }
        
        self.network.fetchPeopleByName(deepLink.name) { [weak self] in
            switch $0 {
            case .success(let page):
                guard let person = page.all.first else { return }
                self?.showPersonDetails(withPerson: person)
            case .failure(let error):
                Log.print(error)
            }
        }
    }
}
