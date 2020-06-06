//
//  PetitionsView.swift
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

final class PetitionsView: UIView {
        
    private lazy var customNavigationBar: UIView = {
        let customNavigationBar = UIView()
        customNavigationBar.backgroundColor = Self.CustomNavigationBarBackgroundColor
        return customNavigationBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = Self.TableViewBackgroundColor
        return tableView
    }()

    private lazy var navigationLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.petitions.uppercased()
        label.textColor = Self.CustomNavigationBarTextColor
        return label
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        backgroundColor = Self.BackgroundColor
        
        styleLabels()
    }

    private var hasLayedOutSubviews = false
    private func createLayout() {
        super.updateConstraints()
        
        guard !hasLayedOutSubviews else { return }
        hasLayedOutSubviews = true
                
        createCustomNavigationBarLayout()
        addSubview(customNavigationBar)
        
        addSubview(tableView)

        // all subviews should use custom constraints
        [
            customNavigationBar,
            tableView,
            ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    // ensure that updateConstraints is always called
    override class var requiresConstraintBasedLayout: Bool { true }
    
    private var haveCreatedConstraints = false
    override func updateConstraints() {
        super.updateConstraints()
                
        createLayout()

        guard !haveCreatedConstraints else { return }
        haveCreatedConstraints = true
        
        NSLayoutConstraint.activate([
            customNavigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            customNavigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: Self.CustomNavigationBarHeight),
            
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createCustomNavigationBarLayout() {
        
        navigationLabel.translatesAutoresizingMaskIntoConstraints = false
        customNavigationBar.addSubview(navigationLabel)
        
        NSLayoutConstraint.activate([
            navigationLabel.centerXAnchor.constraint(equalTo: customNavigationBar.centerXAnchor),
            navigationLabel.centerYAnchor.constraint(equalTo: customNavigationBar.centerYAnchor),
            
        ])
    }
    
    private func styleLabels() {

        navigationLabel.font = UIFont.STN.navBarTitle
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            styleLabels()
        }
    }

}

// MARK: - Constants
extension PetitionsView {
    
    static let CustomNavigationBarHeight: CGFloat = 70
    static let CustomNavigationBarTextColor = UIColor.white
    static let CustomNavigationBarBackgroundColor = UIColor.black
    static let BackgroundColor = UIColor.black
    static let TableViewBackgroundColor = UIColor.systemBackground
}
