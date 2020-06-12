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

enum MoreLinks {
    static let github = "https://github.com/Say-Their-Name/"
    static let slack = "https://saytheirnames.slack.com/join/shared_invite/zt-eqjuatz7-fgh3zPRXIKiiXsC1Vf3oZA#/"
    static let twitter = "https://twitter.com/SayTheirName_io"
    static let contributeToTheList = "https://airtable.com/shr6Da28410B2Muy3"
}

/// The UI for More
final class MoreView: UIView {
    
    private let moreCard = MoreCard()
    
    /// Diplayed sections
    enum MoreSection {
        case about
        case request
        case history
        case didWeMissSomeone
        case contribution
        case developer
        case twitter
    }
    
    private lazy var aboutSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Theme.Components.Padding.small
        
        stack.addArrangedSubview(makeTitleLabel(for: .about))
        stack.addArrangedSubview(makeDescriptionLabel(for: .about, with: L10n.aboutThisProjectDetails))
        
        return stack
    }()
    
    private lazy var historySection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Theme.Components.Padding.small
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(makeTitleLabel(for: .history))
        stack.addArrangedSubview(makeDescriptionLabel(for: .history, with: L10n.MoreHistory.aboutDesc))
        
        return stack
    }()
    
    private lazy var requestSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Theme.Components.Padding.small
        
        stack.addArrangedSubview(makeTitleLabel(for: .request))
        stack.addArrangedSubview(RequestOrRemoveTextView())
        
        return stack
    }()
    
    private lazy var didWeMissSomeoneSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Theme.Components.Padding.small
        
        stack.addArrangedSubview(makeTitleLabel(for: .didWeMissSomeone))
        stack.addArrangedSubview(makeActionButton(for: .didWeMissSomeone))

        return stack
    }()
    
    private lazy var contributionSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Theme.Components.Padding.small
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(makeTitleLabel(for: .contribution))
        stack.addArrangedSubview(makeDescriptionLabel(for: .contribution))
        stack.addArrangedSubview(makeActionButton(for: .contribution))

        return stack
    }()
    
    private lazy var developerSection: UIStackView = {
         let stack = UIStackView()
         stack.axis = .vertical
         stack.spacing = Theme.Components.Padding.small
         stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(makeTitleLabel(for: .developer))
        stack.addArrangedSubview(makeDescriptionLabel(for: .developer))
        stack.addArrangedSubview(makeActionButton(for: .developer))

         return stack
     }()
    
    private lazy var twitterSection: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Theme.Components.Padding.small
        stack.translatesAutoresizingMaskIntoConstraints = false
                  
        stack.addArrangedSubview(makeTitleLabel(for: .twitter))
        stack.addArrangedSubview(makeDescriptionLabel(for: .twitter))
        stack.addArrangedSubview(makeActionButton(for: .twitter))

        return stack
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
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Theme.Components.Padding.extraLarge
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(moreCard)
        stack.addArrangedSubview(aboutSection)
        stack.addArrangedSubview(historySection)
        stack.addArrangedSubview(requestSection)
        stack.addArrangedSubview(didWeMissSomeoneSection)
        stack.addArrangedSubview(contributionSection)
        stack.addArrangedSubview(developerSection)
        stack.addArrangedSubview(twitterSection)
        
        // scroll view
        let scrollView = UIScrollView(frame: frame)
        scrollView.backgroundColor = STNAsset.Color.background.color
        scrollView.addSubview(stack)
        addSubview(scrollView)
        
        scrollView.anchor(superView: self, top: topAnchor, leading: leadingAnchor,
                          bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .zero)
        stack.anchor(superView: scrollView, top: scrollView.topAnchor, leading: scrollView.leadingAnchor,
                     bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor,
                           padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), size: .zero)
        
        NSLayoutConstraint.activate([
            moreCard.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            moreCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            moreCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            moreCard.heightAnchor.constraint(equalTo: moreCard.widthAnchor, multiplier: 0.6)
        ])
        
        moreCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openTwitterPage(_:))))
    }
}

// MARK: - More Section Configuration
private extension MoreView {
    
    func makeTitleLabel(for section: MoreSection) -> UILabel {
        let label = UILabel()
        label.font = UIFont.STN.ctaTitle
        label.textColor = STNAsset.Color.primaryLabel.color
        label.numberOfLines = Theme.Components.LineLimit.double
        label.translatesAutoresizingMaskIntoConstraints = false
        
        switch section {
        case .about:
            label.text = L10n.AboutThisProject.title
        case .history:
            label.text = L10n.MoreHistory.aboutTitle
        case .request:
            label.text = L10n.RequestEditOrRemoval.title
        case .didWeMissSomeone:
            label.text = L10n.didWeMissSomeone
        case .contribution:
            label.text = L10n.GetInvolved.Slack.title
        case .developer:
            label.text = L10n.GetInvolved.Developer.title
        case .twitter:
            label.text = L10n.GetInvolved.Twitter.title
        }
        
        return label
    }
    
    func makeDescriptionLabel(for section: MoreSection, with description: String = "") -> UILabel {
        let label = UILabel()
        label.text = description
        label.font = UIFont.STN.ctaBody
        label.textColor = STNAsset.Color.primaryLabel.color
        label.numberOfLines = Theme.Components.LineLimit.none
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeActionButton(for section: MoreSection) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.STN.sectionHeader
        button.layer.borderWidth = 2
        button.backgroundColor = STNAsset.Color.actionButton.color
        button.setTitleColor(STNAsset.Color.actionButtonTint.color, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        switch section {
        case .didWeMissSomeone:
            button.setTitle(L10n.requestToAddNewName, for: .normal)
            button.addTarget(self, action: #selector(openRequestPage(_:)), for: .touchUpInside)
        case .contribution:
            button.setTitle(L10n.GetInvolved.Slack.button, for: .normal)
            button.addTarget(self, action: #selector(openSlackPage(_:)), for: .touchUpInside)
        case .developer:
            button.setTitle(L10n.GetInvolved.Developer.button, for: .normal)
            button.addTarget(self, action: #selector(openRepositoryPage(_:)), for: .touchUpInside)
        case .twitter:
            button.setTitle(L10n.GetInvolved.Twitter.button, for: .normal)
            button.addTarget(self, action: #selector(openTwitterPage(_:)), for: .touchUpInside)
        default:
            break
        }
        
        return button
    }
}

// MARK: - Button Action Responders
private extension MoreView {
    
    @objc func openRequestPage(_ sender: Any) {
        guard let url = URL(string: MoreLinks.contributeToTheList) else {
            assertionFailure("Failed to create slack url")
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    @objc func openSlackPage(_ sender: Any) {
        guard let url = URL(string: MoreLinks.slack) else {
            assertionFailure("Failed to create slack url")
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    @objc func openTwitterPage(_ sender: Any) {
        guard let url = URL(string: MoreLinks.twitter) else {
            assertionFailure("Failed to create twitter url")
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    @objc func openRepositoryPage(_ sender: Any) {
        guard let url = URL(string: MoreLinks.github) else {
            assertionFailure("Failed to create repo url")
            return
        }
        
        UIApplication.shared.open(url)
    }
}
