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

extension PetitionsResponsePage: PaginatorResponsePage {
    typealias Element = Petition
}

/// Controller responsible for showing the petitions
final class PetitionsController: UIViewController {

    @DependencyInject
    private var network: NetworkRequestor
    
    private let petitionsManager = PetitionsCollectionViewManager()
    private let ui = PetitionsView()
    
    private lazy var paginator: Paginator<Petition, PetitionsResponsePage> = initializePaginator()

    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = ui
    }
    
    private func initializePaginator() -> Paginator<Petition, PetitionsResponsePage> {
        let paginator =
            Paginator<Petition, PetitionsResponsePage>(pageLoader: { [weak self] (link: Link?,
                completion: @escaping (Result<PetitionsResponsePage, Error>) -> Void) in
            if let link = link {
                self?.network.fetchPetitions(with: link, completion: completion)
            } else {
                self?.network.fetchPetitions(completion: completion)
            }
        })
        return paginator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        navigationItem.title = Strings.petitions.localizedUppercase
        setupPaginator()
    }
    
    private func configure() {
        petitionsManager.cellForItem = { [unowned self] (collectionView, indexPath, petition) in
            let cell: CallToActionCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(with: petition)
            cell.executeAction = { [weak self] id in
               self?.showPetitionDetails(with: petition)
            }
            return cell
        }
        
        petitionsManager.willDisplayCell = { [weak self] (collectionView, indexPath) in
            guard let self = self else { return }
             
             guard type(of: collectionView) == CallToActionCollectionView.self,
                 self.petitionsManager.section(at: indexPath.section) == .main else { return }
             
             if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
                 self.paginator.loadNextPage()
             }
        }
        
        ui.bindPetitionManager(petitionsManager)
    }
    
    private func showPetitionDetails(with petition: Petition) {
        let detailVC = PetitionDetailViewController()
        detailVC.petition = petition
        let navigationController = UINavigationController(rootViewController: detailVC)
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    private func setupPaginator() {
        paginator.firstPageDataLoadedHandler = { [weak self] petitions in
            self?.petitionsManager.set(petitions)
        }
        
        paginator.subsequentPageDataLoadedHandler = { [weak self] petitions in
            self?.petitionsManager.append(petitions, in: .main)
        }
        
        paginator.loadNextPage()
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
