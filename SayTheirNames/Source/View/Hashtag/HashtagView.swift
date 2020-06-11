//
//  HashtagView.swift
//  SayTheirNames
//
//  Created by Leonard Chen on 6/6/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

struct HashtagSizingModel: DynamicHeightCalculable {
        
    public func height(forWidth: CGFloat) -> CGFloat {
        let sizingLabel = UILabel()
        sizingLabel.text = "#JUSTICEFORFIRST"
        sizingLabel.font = UIFont.STN.hashtagButton
        sizingLabel.adjustsFontForContentSizeCategory = true
        sizingLabel.textColor = UIColor(asset: STNAsset.Color.primaryLabel)
        sizingLabel.textAlignment = .center
        sizingLabel.isAccessibilityElement = true

        let maxSize = CGSize(width: forWidth, height: .greatestFiniteMagnitude)
        let size = sizingLabel.sizeThatFits(maxSize)
        
        return size.height
    }
}

class HashtagView: UIView {
    // MARK: - View
    lazy var hashtagLabel: UILabel = {
        let label = UILabel()
        label.text = "#JUSTICEFORFIRST"
        label.font = UIFont.STN.hashtagButton
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor(asset: STNAsset.Color.primaryLabel)
        label.textAlignment = .center
        label.isAccessibilityElement = true
        return label
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
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
                            padding: UIEdgeInsets(top: Theme.Components.Padding.small,
                                                  left: Theme.Components.Padding.small,
                                                  bottom: Theme.Components.Padding.small,
                                                  right: Theme.Components.Padding.small),
                            size: .zero)
    }
    
    private func updateCGColors() {
        layer.borderColor = UIColor(asset: STNAsset.Color.primaryLabel).cgColor
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.updateCGColors()
        self.setNeedsDisplay()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: self.hashtagLabel.frame.width + (Theme.Components.Padding.small * 2),
                      height: self.hashtagLabel.frame.height + (Theme.Components.Padding.small * 2))
    }
}
