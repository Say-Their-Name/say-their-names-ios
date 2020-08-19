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

extension PersonsResponsePage: PaginatorResponsePage {
    typealias Element = Person
}

final class HomeController: UIViewController {
    @DependencyInject private var network: NetworkRequestor
    
    required init() {
        
        weak var weakSelf: HomeController?
        
        self.paginator =
            Paginator<Person, PersonsResponsePage>(pageLoader: { (link: Link?, completion: @escaping (Result<PersonsResponsePage, Error>) -> Void) in
            guard let strongSelf = weakSelf else { return }
            
            // call network
            if let link = link {
                strongSelf.network.fetchPeopleWithLink(link, completion: completion)
            }
            else {
                strongSelf.network.fetchPeople(completion: completion)
            }
        })
        super.init(nibName: nil, bundle: nil)
        
        weakSelf = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - CONSTANTS

    private let paginator: Paginator<Person, PersonsResponsePage>
    
    // MARK: - CV Data Sources
    private lazy var locationsDataSourceHelper = LocationCollectionViewDataSourceHelper(collectionView: locationCollectionView)
    private lazy var peopleDataSourceHelper = PersonCollectionViewDataSourceHelper(collectionView: peopleCollectionView)
    
    private lazy var homeView = HomeView()
        
    private var locationCollectionView: UICollectionView { homeView.locationCollectionView }
    private var peopleCollectionView: UICollectionView { homeView.peopleCollectionView }    
    
    // MARK: - ClASS METHODS

    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = L10n.sayTheirNames.localizedUppercase
        
        setupHomeView()
        setupCollectionView()
        setupSearchButton()
        setupPaginator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if peopleDataSourceHelper.hasPeople == false {
            self.paginator.loadNextPage()
        }

        // Select first location by default
        // FIXME: can have multiple selected. need one source-of-truth here.
        guard FeatureFlags.filtersEnabled else { return }
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        locationCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupHomeView() {
        homeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeView)
        homeView.peopleDataSource = peopleDataSourceHelper

        homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        homeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupSearchButton() {
        guard FeatureFlags.searchEnabled else { return }
        let searchImage = UIImage(asset: STNAsset.Image.searchWhite)?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: searchImage,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(searchButtonPressed(_:)))
    }
    
    private func setupCollectionView() {
        
        // TO-DO: Dummy data for now, should update after API call to get locations
        let locations: [Location] = [.init(name: "ALL"),
                         .init(name: "RECENT"),
                         .init(name: "MISSOURI"),
                         .init(name: "TEXAS"),
                         .init(name: "NEW YORK")]

        locationsDataSourceHelper.setLocations(locations)
        
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = locationsDataSourceHelper.dataSource
        locationCollectionView.accessibilityIdentifier = "locationCollection"
        peopleCollectionView.delegate = self
        peopleCollectionView.dataSource = peopleDataSourceHelper.dataSource
        peopleCollectionView.accessibilityIdentifier = "peopleCollection"
    }
    
    private func setupPaginator() {
        // MARK: - Carousel data
        
        let carouselData: [HeaderCellContent] = FeatureFlags.carouselOnHome ? [
            .init(title: "#BLACKLIVESMATTER", description: "How to get involved - donate now!"),
            .init(title: "#BLACKLIVESMATTER", description: "How to get involved"),
            .init(title: "#BLACKLIVESMATTER", description: "How to get involved")
            ] : []
        
        self.peopleDataSourceHelper.setPeople([], carouselData: carouselData)

        paginator.firstPageDataLoadedHandler = { [weak self] (data: [Person]) in
            self?.peopleDataSourceHelper.setPeople(data, carouselData: carouselData)
        }
        paginator.subsequentPageDataLoadedHandler = { [weak self] (data: [Person]) in
            self?.peopleDataSourceHelper.appendPeople(data)
        }
        
        paginator.loadNextPage()
    }
    
    // MARK: - Button Actions
    @objc private func searchButtonPressed(_ sender: Any) {
        UIImpactFeedbackGenerator().impactOccurred()
        hideBackButtonTitle()
        navigationController?.pushViewController(SearchController(), animated: true)
    }
    
    private func showPersonDetails(withPerson: Person) {
        self.dismiss(animated: false)
        
        let personController = PersonController()
        personController.person = withPerson
        
        let navigationController = UINavigationController(rootViewController: personController)
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
        } else if collectionView === peopleCollectionView {
            // People CollectionView
            guard peopleDataSourceHelper.section(at: indexPath.section) == .main else { return }
            guard let selectedPerson = peopleDataSourceHelper.person(at: indexPath.item) else { return }
            self.showPersonDetails(withPerson: selectedPerson)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard collectionView === peopleCollectionView else { return }
        guard peopleDataSourceHelper.section(at: indexPath.section) == .main else { return }
        
        if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            paginator.loadNextPage()
        }
    }
}

extension HomeController: DeepLinkPresenter {
    func handle(deepLink: DeepLink) {
        guard let deepLink = deepLink as? PersonDeepLink else { return }
        
        self.network.fetchPersonDetails(with: deepLink.value) { [weak self] in
            switch $0 {
            case .success(let page):
                self?.showPersonDetails(withPerson: page.person)
            case .failure(let error):
                Log.print(error)
            }
        }
    }
}
