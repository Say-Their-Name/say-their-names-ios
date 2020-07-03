//
//  LineCarouselControl.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
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

// This file is currently unused.
// Will be useful when/if we implement paging control under the carousel section!

protocol LineCarouselControlProtocol: class {
    func didSelectLineAt(_ index: Int)
}

final class LineCarouselControl: UIControl {

    // MARK: - Properties
    private var pageIndicatorTintColor: UIColor? = UIColor(asset: STNAsset.Color.gray)
    private var currentPageIndicatorTintColor: UIColor? = UIColor(asset: STNAsset.Color.black)
    private lazy var stackView = UIStackView.init(frame: self.bounds)
    override var bounds: CGRect {
        didSet(oldValue) {
            self.numberOfLines.forEach {
                self.setupLineAppearance($0)
            }
        }
    }
    var numberOfLines = [UIView]() {
        didSet(oldValue) {
            if numberOfLines.count == numberOfPages {
                setupViews()
            }
        }
    }
    var numberOfPages: Int = 0 {
        didSet(oldValue) {
            for tag in 0 ..< numberOfPages {
                Log.print(tag)
                let line = getLineView()
                line.tag = tag
                self.numberOfLines.append(line)
            }
        }
    }
    var currentPage: Int = 0 {
        didSet(oldValue) {
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

    // MARK: - Intialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log.print("An error occured")
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
                $0.heightAnchor.constraint(equalTo: self.stackView.heightAnchor, multiplier: 0.3, constant: 0),
                $0.widthAnchor.constraint(equalToConstant: 35)
            ])
        }
    }

    @objc private func onPageControlTapped(_ sender: UITapGestureRecognizer) {
        guard let selectedLine = sender.view else { return }
        delegate?.didSelectLineAt(selectedLine.tag)
        _ = numberOfLines.forEach { view in
            if view.tag == selectedLine.tag {
                currentPage = selectedLine.tag
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
