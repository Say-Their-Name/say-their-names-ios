//
//  Services.swift
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

// MARK: - Dependency
protocol Dependency {
    
}

// MARK: - DependencyContainer
final class DependencyContainer: Dependency {
    lazy private(set) var navigator = Navigator()
    lazy private(set) var image = ImageService()
    lazy private(set) var dateFormatter = DateFormatterService()
    lazy private(set) var network = NetworkRequestor()
    
    // MARK: - Init
    init() {
        Log.mode = .all
        Log.print("SayTheirNames Version: \(Bundle.versionBuildString)")
        Log.print("Starting Services")
        
        // Handle our Injection
        let injectionFactory = DependencyInjectionFactory.notShared
        injectionFactory.add(handle: self)
        injectionFactory.add(handle: self.navigator)
        injectionFactory.add(handle: self.image)
        injectionFactory.add(handle: self.dateFormatter)
        injectionFactory.add(handle: self.network)
    }
}

// MARK: - ServiceInject
@propertyWrapper
struct DependencyInject<S: Dependency> {
    var serviceHandle: S
    
    init() {
        self.serviceHandle = DependencyInjectionFactory.notShared.resolve(S.self)
    }
    
    public var wrappedValue: S {
        get { serviceHandle }
        mutating set { serviceHandle = newValue }
    }
}

// MARK: - InjectionFactory
private class DependencyInjectionFactory {
    static let notShared = DependencyInjectionFactory()
    var factoryDict: [String: Any] = [:]
    
    func add<S: Dependency>(handle: S) {
        let key = String(describing: handle.self)
        self.factoryDict[key] = handle
    }

    func resolve<S: Dependency>(_ type: S.Type) -> S {
        let key = String(reflecting: type)
        let component = self.factoryDict[key]
        
        return component as! S
    }
}
