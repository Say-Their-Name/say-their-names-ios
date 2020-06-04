//
//  PetitionsView.swift
//  Say Their Names
//
//  Created by Joseph A. Wardell on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

final class PetitionsView: UIView {

    let title: String
    
    init(title: String)
    {
        self.title = title
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) { fatalError("This should not be called") }
    
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

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        backgroundColor = Self.BackgroundColor
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
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.STN.navBarTitle
        label.textColor = Self.CustomNavigationBarTextColor
                                        
        label.translatesAutoresizingMaskIntoConstraints = false
        customNavigationBar.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: customNavigationBar.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: customNavigationBar.centerYAnchor),
            
        ])
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
