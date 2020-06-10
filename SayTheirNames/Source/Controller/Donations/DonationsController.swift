//
//  DonationsController.swift
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

extension DonationsResponsePage: PaginatorResponsePage {
    typealias Element = Donation
}

final class DonationsController: UIViewController {

    @DependencyInject
    private var network: NetworkRequestor
    
    private let donationManager = DonationsCollectionViewManager()
    private let filterManager = DonationFilterViewManager()
    private let ui = DonationsView()
    private var donations: [Donation]?

    private let paginator: Paginator<Donation, DonationsResponsePage>
    
    required init() {
        weak var weakself: DonationsController?
        self.paginator =
            Paginator<Donation, DonationsResponsePage> { (link: Link?, completion: @escaping (Result<DonationsResponsePage, Error>) -> Void) in
                guard let self = weakself else { return }
                if let link = link {
                    self.network.fetchDonations(with: link, completion: completion)
                } else {
                    self.network.fetchDonations(completion: completion)
                }
        }
        super.init(nibName: nil, bundle: nil)
        weakself = self
    }
    
    required init?(coder: NSCoder) {  fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Strings.donations.localizedUppercase
        configure()
        setupPaginator()
    }
    
    private func configure() {
        donationManager.cellForItem = { [unowned self] (collectionView, indexPath, donation) in
            let cell: CallToActionCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(with: donation)
            cell.executeAction = self.moreButtonPressed
            return cell
        }

        donationManager.didSelectItem = { [weak self] donation in
            guard let self = self else { return }
            self.showDonationsDetail(with: donation)
        }
        
        donationManager.willDisplayCell = { [weak self] (collectionView, indexPath) in
            guard let self = self else { return }
            
            guard type(of: collectionView) == CallToActionCollectionView.self,
                self.donationManager.section(at: indexPath.section) == .main else { return }
            
            if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
                self.paginator.loadNextPage()
            }
        }
        
        ui.bindDonationManager(donationManager)
        
        filterManager.cellForItem = { (collectionView, indexPath, filter) in
            let cell: FilterCategoryCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(with: filter)
            return cell
        }
        filterManager.didSelectItem = { filter in
            print(filter)
        }
        ui.bindFilterManager(filterManager)
    }
    
    private func showDonationsDetail(with donation: Donation) {
        let detailVC = DonationsMoreDetailsController()
        detailVC.donation = donation
        let navigationController = UINavigationController(rootViewController: detailVC)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    private func setupPaginator() {
        paginator.firstPageDataLoadedHandler = { [weak self] (data: [Donation]) in
            self?.donationManager.set(data)
        }
        
        paginator.subsequentPageDataLoadedHandler = { [weak self] (data: [Donation]) in
            self?.donationManager.append(data, in: .main)
        }
        
        paginator.loadNextPage()
    }
    
    private func showDontationsDetails(withDonation: Donation) {
        let detailVC = DonationsMoreDetailsController()
        detailVC.donation = withDonation
        let navigationController = UINavigationController(rootViewController: detailVC)
        
        self.present(navigationController, animated: true)
    }
    
    private lazy var moreButtonPressed: ((Int?) -> Void) = { [unowned self] id in
        guard
            let id = id,
            let donation = self.donations?.first(where: { $0.id == id })
            else { return }
        
        self.showDontationsDetails(withDonation: donation)
    }
}

extension DonationsController: DeepLinkPresenter {
    func handle(deepLink: DeepLink) {
        guard let deepLink = deepLink as? DonateDeepLink else { return }
        
        self.network.fetchDonationDetails(with: deepLink.value) { [weak self] in
            switch $0 {
            case .success(let page):
                self?.showDontationsDetails(withDonation: page.donation)

            case .failure(let error):
                Log.print(error)
             }
        }
    }
}
