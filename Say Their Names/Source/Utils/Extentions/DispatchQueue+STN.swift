//
//  DispatchQueue+STN.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

public extension DispatchQueue {
    class func mainAsync(execute: @escaping @convention(block) () -> Swift.Void) {
        self.main.async(execute: execute)
    }
    
    class func asyncAfter(_ seconds: TimeInterval, execute: @escaping @convention(block) () -> Swift.Void) {
        self.main.asyncAfter(deadline: DispatchTime.now() + seconds, execute: execute)
    }
    
    class func global(execute: @escaping @convention(block) () -> Swift.Void) {
        self.global(qos: .background).async(execute: execute)
    }
}
