//
//  DMDDonationButtonSupplementaryView.swift
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

class DMDDonationButtonSupplementaryView: UICollectionReusableView {
    // MARK: - Property
    static let reuseIdentifier = "donations-more-details-button-view"
    private var buttonPressedAction: (() -> Void)?
    
    // MARK: - View
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.donate.uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.STN.sectionHeader
        button.backgroundColor = .black
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonDidPress(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        clipsToBounds = true
        button.fillSuperview(superView: self, padding: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Button Action
    @objc private func buttonDidPress(_ sender: Any) {
        buttonPressedAction?()
    }
    
    // MARK: - Method
    public func setButtonPressed(action: @escaping () -> Void) {
        buttonPressedAction = action
    }
}
