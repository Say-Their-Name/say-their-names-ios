//
//  SearchViewController.swift
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

class SearchViewController: UIViewController {
    
    var people = [Person]()
    var searchResult = [Person]()
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let searchBarContainer = UIView()
    private lazy var stackView = UIStackView(arrangedSubviews: [backButton, searchContainerView])
    private lazy var innerStackView = UIStackView(arrangedSubviews: [searchImageView, searchBar])
    
    // MARK: - UI Elements
    private let searchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = .init(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.3
        return view
    }()

    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = STNImage.search.image
        imageView.tintColor = UIColor.STN.black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(STNImage.arrowLeft.image, for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        button.backgroundColor = UIColor.STN.black
        button.tintColor = UIColor.STN.white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchResult = self.people
        setupViews()
        setupTableView()
        setupSearchBar()
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        searchBarContainer.anchor(
            superView: view, top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor, trailing: view.trailingAnchor,
            size: Theme.Screens.Search.barSize)
        backButton.anchor(size: .init(width: 50, height: 50))
        stackView.spacing = Theme.Components.Padding.medium
        stackView.anchor(
            superView: searchBarContainer, leading: searchBarContainer.leadingAnchor,
            bottom: searchBarContainer.bottomAnchor,
            trailing: searchBarContainer.trailingAnchor,
            padding: .init(left: 16, bottom: 16, right: 16),
            size: .init(width: 0, height: 50))
        innerStackView.anchor(
            superView: searchContainerView, leading: searchContainerView.leadingAnchor,
            trailing: searchContainerView.trailingAnchor, padding: .init(left: 8,right: 8))
        innerStackView.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor).isActive = true
        searchImageView.anchor(size: .init(width: 30, height: 30))
    }
    
    fileprivate func setupSearchBar() {
        searchBar.searchTextField.font = UIFont(name: "Karla-Regular", size: 16)
        searchBar.tintColor = UIColor.STN.black
        searchBar.barStyle = .black
        searchBar.backgroundColor = UIColor.STN.white
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
    }
    
    fileprivate func setupTableView() {
        tableView.anchor(
            superView: view,
            top: searchBarContainer.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor)
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SearchResultCell.self)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
    }
    
    func setPeople(_ people: [Person]){
        self.people = people
    }
    
    @objc func handleBackButton() {
        searchBar.resignFirstResponder()
        navigationController?.navigationBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.font = UIFont(name: "Karla-Bold", size: 17)
        cell.textLabel?.text = searchResult[indexPath.row].fullName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Theme.Screens.Search.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let selectedPerson = searchResult[indexPath.row]
        let personController = PersonController()
        personController.person = selectedPerson
        let navigationController = UINavigationController(rootViewController: personController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let searchText = searchBar.text?.lowercased() {
            self.searchResult = self.people.filter({ (person) -> Bool in
                return person.fullName.lowercased().contains(searchText)
            })
        }
        
        if searchResult.isEmpty {
            self.searchResult = self.people
        }
        
        self.tableView.reloadData()
    }
}
