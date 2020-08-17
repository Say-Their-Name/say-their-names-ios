//
//  SearchController.swift
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

final class SearchController: UIViewController {
    
    @DependencyInject private var network: NetworkRequestor
    
    private var dataSource: UITableViewDiffableDataSource<SingleSection, Person>?
    
    private let ui = SearchView()
    
    override func loadView() {
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        configureSubviews()
    }
    
    private func setupSelf() {
        navigationItem.titleView = ui.searchBar
        ui.searchBar.becomeFirstResponder()
    }
    
    private func configureSubviews() {
        ui.searchBar.delegate = self
        ui.searchResultsTableView.delegate = self
        dataSource = UITableViewDiffableDataSource(tableView: ui.searchResultsTableView) { (tableView, indexPath, person) in
            let cell: SearchResultCell = tableView.dequeueCell(for: indexPath)
            cell.populate(with: person)
            return cell
        }
        ui.searchResultsTableView.register(cellType: SearchResultCell.self)
    }
    
    private func search(for criteria: String) {
        network.fetchPeopleByName(criteria) { [weak self] result in
            switch result {
            case .success(let response):
                self?.createSnapshot(with: response.all)
                self?.ui.toggleBackgroundView(on: response.all.isEmpty)
                
            case .failure(let error):
                Log.print(error)
            }
        }
    }
    
    private func createSnapshot(with people: [Person]) {
        var snapshot = NSDiffableDataSourceSnapshot<SingleSection, Person>()
        snapshot.appendSections([.main])
        snapshot.appendItems(people)
        dataSource?.apply(snapshot)
    }
    
    private func showDetails(for person: Person) {
        let personController = PersonController()
        personController.person = person
        
        let navigationController = UINavigationController(rootViewController: personController)
        present(navigationController, animated: true)
    }
}

extension SearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            createSnapshot(with: [])
            ui.toggleBackgroundView(on: true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        search(for: searchText)
    }
}

extension SearchController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let person = dataSource?.itemIdentifier(for: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        showDetails(for: person)
    }
}
