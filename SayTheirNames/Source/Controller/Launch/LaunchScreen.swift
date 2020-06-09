//
//  LaunchScreen.swift
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

final class LaunchScreen: UIView {
    
    @IBOutlet weak var logo: UIImageView!
    
    @available(*, unavailable, message: "Use createFromNib() method instead")
    override init(frame: CGRect) {
        fatalError()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    static func createFromNib() -> LaunchScreen? {
        let bundle = Bundle(for: LaunchScreen.self)
        guard let view = bundle.loadNibNamed("LaunchScreen", owner: nil)?.first as? LaunchScreen else {
            print("Can't load `LaunchScreen` from nib")
            return nil
        }
        view.backgroundColor = UIColor(asset: STNAsset.Color.black)
        return view
    }
    
    public func animate(completion: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.logo.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        },
            completion: { _ in
                self.endAnimation(completion: completion)
        })
    }
    
    private func endAnimation(completion: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            options: .curveEaseIn,
            animations: {
                self.logo.transform = CGAffineTransform(scaleX: 4, y: 4)
        },
            completion: { _ in
                completion()
        })
    }
}
