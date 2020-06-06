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

final class HomeController: UIViewController, ServiceReferring {
    let service: Servicing
    
    required init(service: Servicing) {
        self.service = service
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
    
    var customNavBar: UIView { homeView.customNavigationBar }
    
    private var locationCollectionView: UICollectionView { homeView.locationCollectionView }
    private var peopleCollectionView: UICollectionView { homeView.peopleCollectionView }
    private var searchButton: UIButton { homeView.searchButton }
    
    // MARK: - ClASS METHODS
    override func loadView() {
        self.view = homeView
        homeView.peopleDataSource = peopleDataSourceHelper
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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonPressed(_:)), for: .touchUpInside)
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
        self.service.network.fetchPeople { [weak self] (result) in
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
    
    // MARK: - IBACTIONS
    @IBAction func searchButtonPressed(_ sender: Any) {
        UIImpactFeedbackGenerator().impactOccurred()
        searchBar.show()
    }
}

// MARK: - UICOLLECTIONVIEW EXTENSION
extension HomeController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === locationCollectionView {
            return CGSize(width: 103, height: 36)
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
            
            let selectedPerson = peopleDataSourceHelper.person(at: indexPath.item)
            let personController = PersonController(service: self.service)
            personController.person = selectedPerson
            let navigationController = UINavigationController(rootViewController: personController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        }
    }
}
