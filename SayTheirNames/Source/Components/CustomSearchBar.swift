//
//  CustomSearchBar.swift
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

protocol CustomSearchBarDelegate: class {
    func didSelect(person selectedPerson: Person)
}
class CustomSearchBar: UIView {
    
    var people = [Person]()
    var searchResult = [Person]()
    weak var delegate: CustomSearchBarDelegate?
    
    private let searchBar = UISearchBar()
    private let searchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = .init(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.3
        return view
    }()
    private var homeController: HomeController? // FIXME: retain cycle
    private let searchResultView: UIView = {
        let view = UIView()
        return view
    }()
    private let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = STNImage.search.image
        imageView.tintColor = UIColor.STN.black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cancelSearchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.cancel, for: .normal)
        button.addTarget(self, action: #selector(hideSearchBar), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Karla-Bold", size: 17)
        button.tintColor = UIColor.STN.black
        return button
    }()
    
//    private var statusBarAnimatableConfig: StatusBarAnimatableConfig {
//        return StatusBarAnimatableConfig(prefersHidden: false, animation: .slide)}
    
    open func setup(withController controller: HomeController, andView hoemView: UIView) {
        let window = UIApplication.shared.keyWindow!
        self.homeController = controller
        let superView = window
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.STN.white
        textFieldInsideSearchBar?.leftView?.tintColor = UIColor.STN.white
        alpha = 0
        backgroundColor = .white
        searchResultView.alpha = 0
        anchor(
            superView: superView,
            top: superView.topAnchor,
            leading: superView.leadingAnchor,
            trailing: superView.trailingAnchor,
            size: Theme.Screens.SearchBar.size)

        cancelSearchButton.anchor(
            superView: self,
            trailing: trailingAnchor,
            padding: UIEdgeInsets(right: Theme.Components.Padding.medium))

        searchContainerView.anchor(
            superView: self,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: cancelSearchButton.leadingAnchor,
            padding: UIEdgeInsets(
                left: Theme.Components.Padding.medium,
                bottom: Theme.Components.Padding.medium,
                right: Theme.Components.Padding.medium),
                size: .init(width: 0, height: 45))
        
        searchImageView.anchor(
            superView: searchContainerView, leading: searchContainerView.leadingAnchor,
            padding: .init(left: 18), size: .init(width: 23, height: 23))
        searchImageView.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor).isActive = true
        searchBar.anchor(
            superView: searchContainerView, leading: searchImageView.trailingAnchor,
            trailing: searchContainerView.trailingAnchor, padding: .init(left: 0, right: 16),
                         size: .init(width: 0, height: 40))
        searchBar.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor).isActive = true
        cancelSearchButton.centerYAnchor.constraint(equalTo: searchContainerView.centerYAnchor).isActive = true

        searchResultView.anchor(
            superView: superView,
            top: bottomAnchor,
            leading: superView.leadingAnchor,
            bottom: superView.bottomAnchor,
            trailing: superView.trailingAnchor,
            padding: .init(top: -Theme.Components.Padding.tiny))
        
        tableView.anchor(
            superView: searchResultView,
            top: searchResultView.topAnchor,
            leading: searchResultView.leadingAnchor,
            bottom: searchResultView.bottomAnchor,
            trailing: searchResultView.trailingAnchor)
        
        searchResultView.clipsToBounds = false
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SearchResultCell.self)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        searchBar.barStyle = .black
        searchBar.backgroundColor = .white
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.setImage(UIImage(), for: .search, state: .normal)

        let ViewForDoneButtonOnKeyboard = UIToolbar()
        let flexibleSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        ViewForDoneButtonOnKeyboard.sizeToFit()
        let btnDoneOnKeyboard = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBtnFromKeyboardClicked))
        ViewForDoneButtonOnKeyboard.items = [flexibleSpace,btnDoneOnKeyboard]
        searchBar.inputAccessoryView = ViewForDoneButtonOnKeyboard
    }
    
    @objc func doneBtnFromKeyboardClicked() {
        self.endEditing(true)
    }
    
    open func setPeople(passed: [Person]){
        self.people = passed
//        self.searchResult = passed
//        tableView.reloadData()
    }
    open func show() {
        guard homeController != nil else { return }
        self.searchResult = self.people
        tableView.reloadData()
        alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1            
            self.searchResultView.alpha = 1
        }, completion: { _ in
            self.searchBar.becomeFirstResponder()
        })
    }
    
    @objc private func hideSearchBar() {
        guard let homeController = homeController else { return }
        homeController.view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.searchResultView.alpha = 0            
        }, completion: nil)
    }
}

extension CustomSearchBar: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath)
//        cell.isSeperatorViewHidden = indexPath.row == searchResult.count - 1
        cell.textLabel?.font = UIFont(name: "Karla-Bold", size: 17)
        cell.textLabel?.text = searchResult[indexPath.row].fullName
//        cell.data = people[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelect(person: searchResult[indexPath.row])
//        guard let homeController = homeController else { return }
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

            if searchResult.count < 1 {
                self.searchResult = self.people
            }
            self.tableView.reloadData()
    }
}
