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

final class DonationsController: UIViewController {

    private let donationManager = DonationsCollectionViewManager()
    private let filterManager = DonationFilterViewManager()
    private let ui = DonationsView()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDonations()
    }
    
    private func configure() {
        donationManager.cellForItem = { (collectionView, indexPath, donation) in
            let cell: CallToActionCell = collectionView.dequeueCell(for: indexPath)
            cell.configure(with: donation)
            return cell
        }
        donationManager.didSelectItem = { donation in
            
            // TODO: Move this out
            let detailVC = DonationsMoreDetailsController()
            detailVC.donation = donation
            let navigationController = UINavigationController(rootViewController: detailVC)
            
            self.present(navigationController, animated: true, completion: nil)
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
    
    private func getDonations() {
        service.network.fetchDonations { [weak self] result in
            switch result {
            case .success(let response):
                let donations = response.all
                self?.donationManager.set(donations)

            case .failure(let error):
                print(error)
            }
        }
    }
}
