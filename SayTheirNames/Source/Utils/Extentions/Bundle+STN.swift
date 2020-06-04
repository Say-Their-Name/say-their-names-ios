//
//  Bundle+STN.swift
//  SayTheirNames
//
//  Created by evilpenguin on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

extension Bundle {
    public class var mainBundleIdentifier: String? {
        return self.main.bundleIdentifier
    }
    
    public class var versionBuildString: String {
        guard let version = self.version, let build = self.build
        else  { return "Version Unknown" }
        
        return "\(version)-\(build)"
    }
    
    public class var version: String? {
        guard let info = self.main.infoDictionary else { return nil }
        return info["CFBundleShortVersionString"] as? String
    }
    
    public class var build: String? {
        guard let info = self.main.infoDictionary else { return nil }
        return info["CFBundleVersion"] as? String
    }
}
