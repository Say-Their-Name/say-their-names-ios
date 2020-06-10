//
//  PetitionsController.swift
//  Say Their Names
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

/// Controller responsible for showing the petitions
final class PetitionsController: UIViewController {

    @DependencyInject
    private var network: NetworkRequestor
    
    private let petitionsManager = PetitionsCollectionViewManager()
    private let ui = PetitionsView()
    private var petitions: [Petition]?

    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        navigationItem.title = Strings.petitions
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPetitions()
    }
    
    private func configure() {
        petitionsManager.cellForItem = { [unowned self] (collectionView, indexPath, petition) in
            let cell: CallToActionCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(with: petition)
            cell.executeAction = self.moreButtonPressed
            return cell
        }
        ui.bindPetitionManager(petitionsManager)
    }
    
    private func showPetitionDetails(with petition: Petition) {
        let detailVC = PetitionDetailViewController()
        //detailVC.petition = withPetition
        let navigationController = UINavigationController(rootViewController: detailVC)
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    private func getPetitions() {
        network.fetchPetitions { [weak self] result in
            switch result {
            case .success(let response):
                self?.petitions = response.all
                self?.petitions.flatMap { self?.petitionsManager.set($0) }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private lazy var moreButtonPressed: ((Int?) -> Void) = { [unowned self] id in
        guard
            let id = id,
            let petition = self.petitions?.first(where: { $0.id == id })
            else { return }
        self.showPetitionDetails(with: petition)
    }
}

extension PetitionsController: DeepLinkPresenter {
    func handle(deepLink: DeepLink) {
        guard let deepLink = deepLink as? SignDeepLink else { return }
        
        self.network.fetchPetitionDetails(with: deepLink.value) { [weak self] in
            switch $0 {
            case .success(let page):
                self?.showPetitionDetails(with: page.petition)
                Log.print(page)
            case .failure(let error):
                Log.print(error)
            }
        }
    }
}
