//
//  SearchView.swift
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

final class SearchResultsBackgroundView: UIView {
    private lazy var imageView = UIImageView.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = STNAsset.Image.searchVector.image
    }
    
    init() {
        super.init(frame: .zero)
        setupSelf()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupSelf() {
        backgroundColor = STNAsset.Color.background.color
    }
    
    private func setupSubviews() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: Self.thirdHeight),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Self.imageViewDimension),
            imageView.heightAnchor.constraint(equalToConstant: Self.imageViewDimension)
        ])
    }
}

extension SearchResultsBackgroundView {
    private static let imageViewDimension: CGFloat = 120
    private static let thirdHeight: CGFloat = UIScreen.main.bounds.height / 3
}

final class SearchView: UIView {
    
    private(set) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for names" // TODO: localize
        searchBar.searchTextField.textColor = STNAsset.Color.searchBarText.color
        return searchBar
    }()
    
    private lazy var searchResultsBackground = SearchResultsBackgroundView()
    
    private(set) lazy var searchResultsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView() // removing separators below cells
        tableView.separatorInsetReference = .fromCellEdges
        tableView.separatorInset = .zero
        tableView.separatorColor = STNAsset.Color.separator.color
        tableView.backgroundView = searchResultsBackground
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setupSelf()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupSelf() {
        backgroundColor = STNAsset.Color.background.color
    }
    
    private func setupSubviews() {
        addSubview(searchResultsTableView)
        searchResultsTableView.fillSuperview()
    }
    
    func toggleBackgroundView(on: Bool) {
        searchResultsBackground.isHidden = !on
    }
}
