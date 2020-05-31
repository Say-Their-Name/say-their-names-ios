//
//  LaunchScreen.swift
//  Say Their Names
//
//  Created by christopher downey on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

class LaunchScreen: UIView {

    @IBOutlet weak var logo: UIImageView!

    var container: UIView?

    override init(frame: CGRect) {
          super.init(frame: frame)

        loadNib()

      }

      required init?(coder: NSCoder) {
          super.init(coder: coder)

      }


      private func loadNib() {
        let bundle = Bundle(for: LaunchScreen.self)
        if let view = bundle.loadNibNamed("LaunchScreen", owner: nil)?.first as? LaunchScreen {
            addSubview(view)
            view.frame = bounds
        }
      }

    public func animate(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, animations: {
            self.logo.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }) { (_) in
            self.endAnimation(completion: completion)
        }
    }

    private func endAnimation(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn, animations: {
            self.logo.transform = CGAffineTransform(scaleX: 4, y: 4)
        }) { (_) in
            self.removeFromSuperview()
            completion()
        }
    }

}
