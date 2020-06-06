//
//  LineCarouselControl.swift
//  Say Their Names
//
//  Created by Thomas Murray on 06/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

protocol LineCarouselControlProtocol: class {
    func didSelectLineAt(_ index: Int)
}

final class LineCarouselControl: UIControl {

    // MARK: - Properties
    private var pageIndicatorTintColor: UIColor? = UIColor.systemGray4
    private var currentPageIndicatorTintColor: UIColor? = UIColor.STN.black
    private lazy var stackView = UIStackView.init(frame: self.bounds)
    override var bounds: CGRect {
        didSet {
            self.numberOfLines.forEach {
                self.setupLineAppearance($0)
            }
        }
    }
    var numberOfLines = [UIView]() {
        didSet{
            if numberOfLines.count == numberOfPages {
                setupViews()
            }
        }
    }
    var numberOfPages: Int = 0 {
        didSet{
            for tag in 0 ..< numberOfPages {
                print(tag)
                let line = getLineView()
                line.tag = tag
                self.numberOfLines.append(line)
            }
        }
    }
    var currentPage: Int = 0 {
        didSet {
            _ = numberOfLines.map { view in
                if currentPage == view.tag {
                    UIView.animate(withDuration: 0.2, animations: {
                        view.backgroundColor = self.currentPageIndicatorTintColor
                    })
                    self.sendActions(for: .valueChanged)
                } else {
                    view.backgroundColor = self.pageIndicatorTintColor
                }
            }
        }
    }
    weak var delegate: LineCarouselControlProtocol?

    // MARK:- Intialisers
    convenience init() {
        self.init(frame: .zero)
        setupViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("An error occured")
    }

    // MARK: methods
    private func getLineView() -> UIView {
        let line = UIView()
        self.setupLineAppearance(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onPageControlTapped(_:))))
        return line
    }

    private func setupLineAppearance(_ line: UIView) {
        line.transform = .identity
        line.layer.masksToBounds = true
        if currentPage == line.tag {
            line.backgroundColor = currentPageIndicatorTintColor
        } else {
            line.backgroundColor = pageIndicatorTintColor
        }
    }

    private func setupViews() {
        self.numberOfLines.forEach {
            self.stackView.addArrangedSubview($0)
        }
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
        self.numberOfLines.forEach {
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor),
                $0.heightAnchor.constraint(equalTo: self.stackView.heightAnchor, multiplier: 0.2, constant: 0),
                $0.widthAnchor.constraint(equalToConstant: 35)
            ])
        }
    }

    @objc private func onPageControlTapped(_ sender: UITapGestureRecognizer) {
        guard let selectedLine = sender.view else { return }
        delegate?.didSelectLineAt(selectedLine.tag)
        _ = numberOfLines.map { view in
            if view.tag == selectedLine.tag {
                currentPage = selectedLine.tag
                UIView.animate(withDuration: 0.1, animations: {
                    view.backgroundColor = self.currentPageIndicatorTintColor
                })
                self.sendActions(for: .valueChanged)
            } else {
                view.backgroundColor = self.pageIndicatorTintColor
            }
        }
    }

}
