//
//  CarouselPageControl.swift
//  Say Their Names
//
//  Created by Thomas Murray on 03/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class CarouselPageControl: UIPageControl {

    let locationRectangle: UIImage = UIImage(named: "unselected_rectangle")!
    let pageRectangle: UIImage = UIImage(named: "selected_rectangle")!

    override var numberOfPages: Int {
        didSet {
            updateLines()
        }
    }

    override var currentPage: Int {
        didSet {
            updateLines()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.pageIndicatorTintColor = UIColor.clear
        self.currentPageIndicatorTintColor = UIColor.clear
        self.clipsToBounds = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateLines() {
        var i = 0
        for view in self.subviews {
            var imageView = self.imageView(forSubview: view)
            if imageView == nil {
                if i == 0 {
                    imageView = UIImageView(image: locationRectangle)
                } else {
                    imageView = UIImageView(image: pageRectangle)
                }
                imageView!.center = view.center
                view.addSubview(imageView!)
                view.clipsToBounds = false
            }
            if i == self.currentPage {
                imageView!.alpha = 1.0
            } else {
                imageView!.alpha = 0.5
            }
            i += 1
        }
    }

    fileprivate func imageView(forSubview view: UIView) -> UIImageView? {
        var dot: UIImageView?
        if let dotImageView = view as? UIImageView {
            dot = dotImageView
        } else {
            for foundView in view.subviews {
                if let imageView = foundView as? UIImageView {
                    dot = imageView
                    break
                }
            }
        }
        return dot
    }
}
