//
//  DeepLinkHandler.swift
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

final class DeepLinkHandler: Dependency {
    private let deepLinkTypes: [DeepLink.Type]
    private let navigator: Navigator
    
    init(deepLinkTypes: [DeepLink.Type], navigator: Navigator) {
        self.deepLinkTypes = deepLinkTypes
        self.navigator = navigator
    }
    
    // MARK: - Public
    
    public func handle(urlContext: Set<UIOpenURLContext>) {
        self.handle(urls: Set(urlContext.map { $0.url }))
    }
    
    // We use this method as an entry point for unit tests.
    // So we technically don't care about the resulting `DeepLink` array
    // except for the unit tests.
    @discardableResult
    public func handle(urls: Set<URL>) -> [DeepLink] {
        
        var response: [DeepLink] = []
        for url in urls {
             if let deepLink = self.deepLink(matching: url) {
                self.navigator.handle(deepLink: deepLink)
                response.append(deepLink)
            }
        }
        return response
    }
    
    // MARK: - Private
    
    private func deepLink(matching url: URL) -> DeepLink? {
        guard let scheme = url.scheme, let host = url.host
        else { return nil }
        
        for deepLinkType in self.deepLinkTypes {
            let details = deepLinkType.details
            
            if details.uses(scheme: scheme, host: host) {
                var components = url.pathComponents.filter { $0 != "/" }

                // We are navigating to home
                if components.count == 0 {
                    return HomeDeepLink()
                }
                
                // Check location
                guard let location = components.first,
                      let locationIndex = components.firstIndex(of: location)
                else { return nil }
                
                if details.has(location: location) {
                    components.remove(at: locationIndex)
                    
                    // Return DeepLink
                    return deepLinkType.init(components: components)
                }
            }
        }

        return nil
    }
}
