//
//  Paginator.swift
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

import Foundation

protocol PaginatorResponsePage {
    associatedtype Element
    var all: [Element] { get }
    var link: Link { get }
}

final class Paginator<Element, Page: PaginatorResponsePage> where Page.Element == Element {
    
    typealias PageLoaderCompletion = (Result<Page, Error>) -> Void
    typealias PageLoader = (_ link: Link?, _ completion: @escaping PageLoaderCompletion) -> Void
    
    enum State {
        case loading
        case notLoading
    }
    
    @DependencyInject private var network: NetworkRequestor

    private(set) var state: State
    
    let pageLoader: PageLoader
        
    var firstPageDataLoadedHandler: (([Element]) -> Void)?
    var subsequentPageDataLoadedHandler: (([Element]) -> Void)?

    private var pageLink: Link?

    init(pageLoader: @escaping PageLoader) {
        self.pageLoader = pageLoader
        self.state = .notLoading
    }
    
    /// Loads first page
    func refresh() {
        pageLink = nil
        load()
    }
    
    /// Loads next page
    func loadNextPage() {
        load()
    }
    
    private func load() {
        guard state == .notLoading else {
            return
        }
        
        state = .loading
        
        let handler = { [weak self] (result: Result<Page, Error>) in
            guard let self = self else {
                return
            }
            
            switch result {
                
            case .success(let page):
                let isRefresh = self.pageLink == nil
                
                self.pageLink = page.link
                
                if isRefresh {
                    self.firstPageDataLoadedHandler?(page.all)
                }
                else {
                    self.subsequentPageDataLoadedHandler?(page.all)
                }
                
            case .failure(let error):
                Log.print(error)
            }
            
            self.state = .notLoading
        }
        
        self.pageLoader(self.pageLink, handler)
    }
}
