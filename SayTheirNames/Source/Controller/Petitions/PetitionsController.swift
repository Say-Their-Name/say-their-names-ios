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
    init() {
        super.init(nibName: nil, bundle: nil)
    }
        
    private lazy var petitionsView = PetitionsView()
    private var petitionsTableView: UITableView { petitionsView.tableView }

    private lazy var dataSource: PetitionsTableViewDataSource = {
        
        let dataSource = PetitionsTableViewDataSource()
        dataSource.configure(tableView: petitionsTableView)
        
        dataSource.findOutMoreAction = { [weak self] petition in
            
            self?.showDetailViewController(for: petition)
        }
        return dataSource
    }()
        
    required init?(coder: NSCoder) { fatalError("This should not be called") }

    override func loadView() {
        self.view = petitionsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        petitionsTableView.delegate = self
        navigationItem.title = "PETITIONS"
        
        // build mock data for display now
        // in the future, we'll get petitions from the network
        let longTitle = "Editing the new edition of revolution"
        let shortTitle = "Justice for George Floyd"
        
        let dummyPetitions = [
            MockPetition(title: longTitle, verified: true, hasImage: true),
            MockPetition(title: longTitle, verified: false, hasImage: false),
            MockPetition(title: longTitle, verified: true, hasImage: true),
            MockPetition(title: longTitle, verified: true, hasImage: false),
            MockPetition(title: shortTitle, verified: true, hasImage: true),
            MockPetition(title: shortTitle, verified: true, hasImage: false),
            MockPetition(title: shortTitle, verified: false, hasImage: true),
            MockPetition(title: shortTitle, verified: true, hasImage: false)
        ]
        
        dataSource.set(petitions: dummyPetitions)
    }
        
    private func showDetailViewController(for petition: PresentedPetition) {
        
        // People CollectionView
        // let selectedPerson = peopleDataSource.fetchPerson(at: indexPath.item)
        let detailViewController = PetitionDetailViewController(petition: petition)
        
        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.navigationBar.isHidden = true
        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension PetitionsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        // there's no real selected state in this design,
        // we simply show another view controller when the find out more button is tapped
        false
    }
}
