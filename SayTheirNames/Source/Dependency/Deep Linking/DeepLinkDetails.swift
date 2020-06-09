//
//  DeepLinkDetails.swift
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

public struct DeepLinkDetails {
    private var schemes: [String]
    private var hosts: [String]
    private var paths: [PathPart]
    private var displayClass: UIViewController.Type
    private var type: DeepLink.Type
    private enum PathPart { case string(value: String, optional: Bool) }

    // MARK: - Public
    
    init(displayClass: UIViewController.Type, type: DeepLink.Type) {
        self.init(schemes: [], hosts: [], paths: [], displayClass: displayClass, type: type)
    }
    
    public func host(_ host: String) -> DeepLinkDetails {
        return self.appending(schemes: self.schemes, hosts: self.hosts + [host], paths: self.paths)
    }
    
    public func schemes(_ schemes: [String]) -> DeepLinkDetails {
        return self.appending(schemes: self.schemes + schemes, hosts: self.hosts, paths: self.paths)
    }
    
    public func path(_ path: String, optional: Bool = false) -> DeepLinkDetails {
        return self.appending(schemes: self.schemes, hosts: self.hosts, paths: self.paths + [.string(value: path, optional: optional)])
    }
    
    public func canDisplayClass(_ displayClass: UIViewController.Type) -> Bool {
        return self.displayClass == displayClass
    }
    
    public func uses(scheme: String, host: String) -> Bool {
        return self.schemes.contains(scheme) && self.hosts.contains(host)
    }
    
    public func has(location: String) -> Bool {
        for path in self.paths {
            switch path {
            case let .string(value, _):
                if value == location {
                    return true
                }
            }
        }
        
        return false
    }
    
    // MARK: - Private
    
    private func appending(schemes: [String], hosts: [String], paths: [PathPart]) -> DeepLinkDetails {
        return DeepLinkDetails(schemes: schemes,
                               hosts: hosts,
                               paths: paths,
                               displayClass: self.displayClass,
                               type: self.type)
    }

    private init(schemes: [String], hosts: [String], paths: [PathPart], displayClass: UIViewController.Type, type: DeepLink.Type) {
        self.schemes = schemes
        self.hosts = hosts
        self.paths = paths
        self.displayClass = displayClass
        self.type = type
    }
}
