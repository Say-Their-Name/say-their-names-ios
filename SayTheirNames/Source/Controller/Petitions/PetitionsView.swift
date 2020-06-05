//
//  PetitionsView.swift
//  Say Their Names
//
//  Created by Joseph A. Wardell on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

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
