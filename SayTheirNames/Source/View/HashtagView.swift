//
//  HashtagView.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class HashtagView: UIView {
    // MARK: - View
    lazy var hashtagLabel: UILabel = {
        let label = UILabel()
        label.text = "#JUSTICEFORFIRST"
        label.font = UIFont.STN.hashtagButton
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor(asset: STNAsset.Color.primaryLabel)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
        setupLongPressGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Subview
    private func configureView() {
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(asset: STNAsset.Color.primaryLabel).cgColor
        hashtagLabel.anchor(superView: self,
                            top: topAnchor,
                            leading: leadingAnchor,
                            bottom: bottomAnchor,
                            trailing: trailingAnchor,
                            padding: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), size: .zero)
    }
    private func updateCGColors() {
        layer.borderColor = UIColor(asset: STNAsset.Color.primaryLabel).cgColor
    }
    
    private func setupLongPressGestureRecognizer() {
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(copyHashtagToClipboard)))
    }
    
    @objc private func copyHashtagToClipboard(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            print("Copying \(hashtagLabel.text ?? "") to clipboard")
            let pasteBoard = UIPasteboard.general
            if let text = hashtagLabel.text {
                pasteBoard.string = text
            }
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateCGColors()
        self.setNeedsDisplay()
    }
}
