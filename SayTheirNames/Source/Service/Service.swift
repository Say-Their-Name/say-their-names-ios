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

protocol Servicing {
    var navigator: Navigator { get }
    var image: ImageService { get }
    var dateFormatter: DateFormatterService { get }
    var network: NetworkRequestor { get }
}

/// This is a core class that holds all instances responsible for logic
final class Service: Servicing {
    lazy private(set) var navigator = Navigator()
    lazy private(set) var image = ImageService()
    lazy private(set) var dateFormatter = DateFormatterService()
    lazy private(set) var network = NetworkRequestor()
    
    // MARK: - Init
    init() {
        Log.mode = .all
        Log.print("SayTheirNames Version: \(Bundle.versionBuildString)")
        Log.print("Starting Services")
    }
}

@propertyWrapper
struct ServiceInject {
    // DO NOT MAKE THIS PUBLIC!
    private static var hiddenService: Service!
    
    init() { }
    init(service: Service) {
        if ServiceInject.hiddenService == nil {
            ServiceInject.hiddenService = service
        }
    }

    public var wrappedValue: Service {
        ServiceInject.hiddenService
    }
}
