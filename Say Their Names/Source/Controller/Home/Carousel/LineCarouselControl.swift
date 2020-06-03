//
//  LineCarouselControl.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

protocol LineCarouselControlProtocol: class {
    func didSelectLineAt(_ index: Int)
}

class LineCarouselControl: UIControl {

    // MARK: - Properties
    var pageIndicatorTintColor: UIColor? = .lightGray
    var currentPageIndicatorTintColor: UIColor? = .darkGray
    private lazy var stackView = UIStackView.init(frame: self.bounds)
    override var bounds: CGRect {
        didSet{
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
                let line = getLineView()
                line.tag = tag
                line.backgroundColor = pageIndicatorTintColor
                self.numberOfLines.append(line)
            }

        }
    }
    var currentPage: Int = 0 {
        didSet{
            print("CurrentPage is \(currentPage)")
        }
    }
    weak var delegate: LineCarouselControlProtocol?

    //MARK: Helper methods...
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
        line.backgroundColor = pageIndicatorTintColor
    }

    //MARK:- Intialisers
    convenience init() {
        self.init(frame: .zero)
    }

    init(withNoOfPages pages: Int) {
        self.numberOfPages = pages
        self.currentPage = 0
        super.init(frame: .zero)
        setupViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }

    private func setupViews() {
        self.numberOfLines.forEach {
            self.stackView.addArrangedSubview($0)
        }
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        self.add(stackView) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                $0.heightAnchor.constraint(equalTo: self.heightAnchor),
            ])
        }
        self.numberOfLines.forEach {
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: self.stackView.centerYAnchor),
                $0.heightAnchor.constraint(equalTo: self.stackView.heightAnchor, multiplier: 0.15, constant: 0),
                $0.widthAnchor.constraint(equalToConstant: 35)
            ])
        }
    }


    @objc private func onPageControlTapped(_ sender: UITapGestureRecognizer) {
        guard let selectedLine = sender.view else { return }
        delegate?.didSelectLineAt(selectedLine.tag)
        _ = numberOfLines.map {
            setupLineAppearance($0)
            if $0.tag == selectedLine.tag {
                currentPage = selectedLine.tag
                UIView.animate(withDuration: 0.2, animations: {
                    selectedLine.backgroundColor = self.currentPageIndicatorTintColor
                })
                self.sendActions(for: .valueChanged)
            }
        }
    }

}
