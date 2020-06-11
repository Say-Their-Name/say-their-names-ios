//
//  AboutView.swift
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

/// The UI for More
final class MoreView: UIView {
    
    private let moreCard = MoreCard()
    
    /// Diplayed sections
    enum MoreSection {
        case history
        case contribution
        case developer
        case twitter
    }
    
    private lazy var thankYouLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = STNAsset.Color.primaryLabel.color
        label.font = UIFont.STN.ctaTitle
        label.numberOfLines = Theme.Components.LineLimit.double
        label.text = Strings.massiveThankYou
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = STNAsset.Color.white.color
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    /// Configures constraints for subviews
    private func setupSubviews() {
        let contentView = UIStackView(
            arrangedSubviews:
            [moreCard,
             historySection(),
             contributionSection(),
             developerSection(),
             twitterSection(),
             thankYouLabel])
        
        contentView.axis = .vertical
        contentView.spacing = Theme.Components.Padding.extraLarge
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // scroll view
        let scrollView = UIScrollView(frame: frame)
        scrollView.backgroundColor = STNAsset.Color.background.color
        scrollView.addSubview(contentView)
        addSubview(scrollView)
        
        scrollView.anchor(superView: self, top: topAnchor, leading: leadingAnchor,
                          bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .zero)
        contentView.anchor(superView: scrollView, top: scrollView.topAnchor, leading: nil,
                           bottom: nil, trailing: nil,
                           padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), size: .zero)
        
        NSLayoutConstraint.activate([
            moreCard.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            moreCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            moreCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            moreCard.heightAnchor.constraint(equalToConstant: 150),
            thankYouLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

// MARK: - Configurations
private extension MoreView {
        
    private func historySection() -> UIStackView {
        let stackCard = UIStackView(arrangedSubviews: [titleLabel(.history),
                                                       descriptionLabel(.history, description: Strings.MoreHistory.aboutDesc)])
        stackCard.axis = .vertical
        stackCard.spacing = Theme.Components.Padding.small
        stackCard.translatesAutoresizingMaskIntoConstraints = false
        
        return stackCard
    }
    
    private func contributionSection() -> UIStackView {
        let stackCard = UIStackView(arrangedSubviews: [titleLabel(.contribution),
                                                       descriptionLabel(.contribution), actionButton(.contribution)])
        stackCard.axis = .vertical
        stackCard.spacing = Theme.Components.Padding.small
        stackCard.translatesAutoresizingMaskIntoConstraints = false
        
        return stackCard
    }
    
    private func developerSection() -> UIStackView {
        let stackCard = UIStackView(arrangedSubviews: [titleLabel(.developer),
                                                       descriptionLabel(.developer), actionButton(.developer)])
        stackCard.axis = .vertical
        stackCard.spacing = Theme.Components.Padding.small
        stackCard.translatesAutoresizingMaskIntoConstraints = false
        
        return stackCard
    }
    
    private func twitterSection() -> UIStackView {
        let stackCard = UIStackView(arrangedSubviews: [titleLabel(.twitter),
                                                       descriptionLabel(.twitter), actionButton(.twitter)])
        stackCard.axis = .vertical
        stackCard.spacing = Theme.Components.Padding.small
        stackCard.translatesAutoresizingMaskIntoConstraints = false
        
        return stackCard
    }
    
    private func titleLabel(_ section: MoreSection) -> UILabel {
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = STNAsset.Color.primaryLabel.color
        titleLabel.font = UIFont.STN.ctaTitle
        titleLabel.numberOfLines = Theme.Components.LineLimit.double
        
        switch section {
        case .history:
            titleLabel.text = Strings.MoreHistory.aboutTitle
        case .contribution:
            titleLabel.text = Strings.GetInvolved.title
        case .developer:
            titleLabel.text = Strings.GetInvolvedDev.title
        case .twitter:
             titleLabel.text = Strings.GetInvolvedTwitter.title
        }
        
        return titleLabel
    }
    
    private func descriptionLabel(_ section: MoreSection, description: String = "") -> UILabel {
        let bodyLabel = UILabel()
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.textColor = STNAsset.Color.primaryLabel.color
        bodyLabel.font = UIFont.STN.ctaBody
        bodyLabel.numberOfLines = Theme.Components.LineLimit.none
        bodyLabel.text = description
        return bodyLabel
    }
    
    private func actionButton(_ section: MoreSection) -> UIButton {
        let actionButton = UIButton()
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.titleLabel?.font = UIFont.STN.sectionHeader
        actionButton.layer.borderWidth = 2
        actionButton.backgroundColor = STNAsset.Color.actionButton.color
        actionButton.setTitleColor(STNAsset.Color.actionButtonTint.color, for: .normal)
        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let tapGesture = STNTapGestureRecognizer(target: self, action: #selector(openLink(sender:)))
        actionButton.addGestureRecognizer(tapGesture)
        
        switch section {
        case .contribution:
            actionButton.setTitle(Strings.GetInvolved.button, for: .normal)
            tapGesture.value = Strings.GetInvolved.url
        case .developer:
            actionButton.setTitle(Strings.GetInvolvedDev.button, for: .normal)
            tapGesture.value = Strings.GetInvolvedDev.url
        case .twitter:
            actionButton.setTitle(Strings.GetInvolvedTwitter.button, for: .normal)
            tapGesture.value = Strings.GetInvolvedTwitter.url
        case .history: break
        }
        
        return actionButton
    }
    
    @objc private func openLink(sender: STNTapGestureRecognizer) {
        guard let urlString = sender.value,
            let url = URL(string: urlString) else {
                assertionFailure("Failed to extract given url string: \(String(describing: sender.value))")
            return
        }
        
        UIApplication.shared.open(url)
    }
}
