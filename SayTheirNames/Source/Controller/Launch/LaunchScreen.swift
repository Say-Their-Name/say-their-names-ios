//
//  LaunchScreen.swift
//  SayTheirNames
//
//  Created by christopher downey on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

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
        view.backgroundColor = UIColor.STN.black
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
