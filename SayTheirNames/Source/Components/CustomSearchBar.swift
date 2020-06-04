//
//  CustomSearchBar.swift
//  SayTheirNames
//
//  Created by Ahmad Karkouti on 31/05/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class CustomSearchBar: UIView {
    
    var people = [Person]()
    var searchResult = [Person]()
    
    private let searchBar = UISearchBar()
    private var homeController: HomeController?
    private let searchResultView: UIView = {
        let view = UIView()
        return view
    }()
    private let tableView: UITableView = {
        let tv = UITableView()
        return tv
    }()
    private let cancelSearchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(hideSearchBar), for: .touchUpInside)
        return button
    }()
    
    
//    private var statusBarAnimatableConfig: StatusBarAnimatableConfig {
//        return StatusBarAnimatableConfig(prefersHidden: false, animation: .slide)}
    
    
    open func setup(withController controller: HomeController) {
        self.homeController = controller
        guard let superView = controller.view else { return }
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        alpha = 0
        searchResultView.alpha = 0
        anchor(superView: superView, top: superView.safeAreaLayoutGuide.topAnchor, leading: superView.leadingAnchor, trailing: superView.trailingAnchor, size: CGSize(width: 0, height: 60))
        
        cancelSearchButton.anchor(superView: self, top: topAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(right: 16))
        
        searchBar.anchor(superView: self, top: topAnchor , leading: leadingAnchor, bottom: bottomAnchor, trailing: cancelSearchButton.leadingAnchor, padding: UIEdgeInsets(left: 16, right: 16))
        
        searchResultView.anchor(superView: superView, top: bottomAnchor, leading: superView.leadingAnchor, bottom: superView.bottomAnchor, trailing: superView.trailingAnchor, padding: .init(top: -5))
        
        tableView.anchor(superView: searchResultView, top: searchResultView.topAnchor, leading: searchResultView.leadingAnchor, bottom: searchResultView.bottomAnchor, trailing: searchResultView.trailingAnchor)
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: SearchResultCell.self)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        
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
    
    
    open func show() {
        guard let homeController = homeController else { return }
        alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
            homeController.customNavBar.alpha = 0
            self.searchResultView.alpha = 1
            homeController.customNavBar.frame.size = CGSize(width: homeController.view.frame.width, height: self.frame.height + 60)
        }, completion: { finished in
            self.searchBar.becomeFirstResponder()
        })
    }
    
    @objc private func hideSearchBar() {
        guard let homeController = homeController else { return }
        homeController.view.endEditing(true)
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            homeController.customNavBar.alpha = 1
            self.searchResultView.alpha = 0
            homeController.customNavBar.frame.size = CGSize(width: homeController.view.frame.width, height: homeController.view.frame.height)
        }, completion: { finished in
            
        })
    }
}

extension CustomSearchBar: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultCell
        cell.isSeperatorViewHidden = indexPath.row == searchResult.count - 1
        cell.data = searchResult[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
//        guard let homeController = homeController else { return }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}

extension UIEdgeInsets {
    init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.init()
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
}

