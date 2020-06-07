//
//  DMDTextContentCell.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class DMDTextContentCell: UICollectionViewCell {
    // MARK: - Property
    static let reuseIdentifier = "donations-more-details-text-content-cell"
    
    // MARK: - View
    lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = UIFont(name: "Karla-Regular", size: 17)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Class Method
    private func configureSubview() {
        contentView.addSubview(contentTextView)
        contentTextView.fillSuperview(superView: contentView, padding: .zero)
    }
    
    // MARK: - Configure Cell
    func setContent(text: String) {
        contentTextView.text = text
    }
}
