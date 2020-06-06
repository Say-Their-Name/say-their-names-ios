//
//  Theme.swift
//  SayTheirNames
//
//  Created by Berta Devant on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// A collection of common constants for margins and sizes
enum Theme {
    // MARK: - Components
    enum Components {
        // MARK: - Padding
        enum Padding {
            //For cohesive design Most padding used are multiple of 8
            static let tiny: CGFloat = 4
            static let small: CGFloat = 8
            static let medium: CGFloat = 16
            static let large: CGFloat = 32
        }
        // MARK: - Button
        enum Button {
            enum Size {
                static let medium: CGSize = .init(width: 40, height: 40)
            }
        }
    }
    
    // MARK: - Screens
    enum Screens {
        // MARK: - Home
        enum Home {
            enum Columns {
                static let portrait: CGFloat = 2
                static let landscape: CGFloat = 4
            }
            enum CellSize {
                static let location: CGSize = CGSize(width: 103, height: 36)
                static let peopleHeight: CGFloat = 300
            }
            enum HeaderSize {
                static let location: CGSize = .zero
                static let peopleHeight: CGFloat = 170
            }
            enum NavigationBar {
                static let size: CGSize = .init(width: 0, height: 70)
            }
            enum LocationView {
                static let size: CGSize = .init(width: 0, height: 70)
            }
            enum SeparatorView {
                static let size: CGSize = .init(width: 0, height: 1)
            }
            enum Person {
                static let cellSpacing: CGFloat = 15
            }
        }
        
    }
}
