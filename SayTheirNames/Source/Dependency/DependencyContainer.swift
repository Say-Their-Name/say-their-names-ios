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
    let navigator = Navigator()
    let image = ImageService()
    let dateFormatter = DateFormatterService()
    let network = NetworkRequestor()
    let deepLinkHandler: DeepLinkHandler
    let metadata = MetadataService()
    let shareService = ShareService()
    
    // MARK: - Init
    init() {
        Log.mode = .all
        Log.print("SayTheirNames Version: \(Bundle.versionBuildString)")
        Log.print("Starting Services")
        
        // Handler
        let deepLinkTypes: [DeepLink.Type] = [
            HomeDeepLink.self,
            PersonDeepLink.self,
            DonationsDeepLink.self,
            DonateDeepLink.self,
            PetitionsDeepLink.self,
            SignDeepLink.self,
            AboutDeepLink.self
        ]
        self.deepLinkHandler = DeepLinkHandler(deepLinkTypes: deepLinkTypes, navigator: self.navigator)
        
        // Handle our Injection
        let injectionFactory = __DependencyInjectionFactory.shared
        injectionFactory.add(handle: self)
        injectionFactory.add(handle: self.navigator)
        injectionFactory.add(handle: self.image)
        injectionFactory.add(handle: self.dateFormatter)
        injectionFactory.add(handle: self.network)
        injectionFactory.add(handle: self.deepLinkHandler)
        injectionFactory.add(handle: self.metadata)
        injectionFactory.add(handle: self.shareService)
    }
}

// MARK: - DependencyInject
@propertyWrapper
struct DependencyInject<D: Dependency> {
    var dependency: D
    
    init() {
        self.dependency = __DependencyInjectionFactory.shared.resolve(D.self)
    }
    
    public var wrappedValue: D {
        get { dependency }
        mutating set { dependency = newValue }
    }
}

// MARK: - DependencyInjectionFactory
private class __DependencyInjectionFactory {
    static let shared = __DependencyInjectionFactory()
    var factoryDict: [String: Any] = [:]
    
    func add<D: Dependency>(handle: D) {
        let key = String(describing: handle.self)
        self.factoryDict[key] = handle
    }

    func resolve<D: Dependency>(_ type: D.Type) -> D {
        let key = String(reflecting: type)
        guard let component = self.factoryDict[key] as? D else {
            fatalError("Factory component is not of type \(D.self).")
        }
        
        return component
    }
}
