//
//  HomeViewModel.swift
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

final class HomeViewModel {
    
    enum State {
        case loading
        case notLoading
    }
    
    @DependencyInject private var network: NetworkRequestor

    private var pageLink: Link?
    private(set) var state: State
    
    // TODO: maybe better names
    
    var firstPageDataLoadedHandler: (([Person], [HeaderCellContent]) -> Void)?
    var moreDataLoadedToAppendHandler: (([Person]) -> Void)?

    init() {
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
        
        let handler = { [weak self] (result: Result<PersonsResponsePage, Swift.Error>) in
            guard let self = self else {
                return
            }
            
            switch result {
                
            case .success(let page):
                let isRefresh = self.pageLink == nil
                
                self.pageLink = page.link
                if isRefresh {
                    self.firstPageDataLoadedHandler?(page.all, self.carouselData)
                }
                else {
                    self.moreDataLoadedToAppendHandler?(page.all)
                }
                
            case .failure(let error):
                Log.print(error)
            }
            
            self.state = .notLoading
        }
        
        if let pageLink = self.pageLink {
            self.network.fetchPeopleWithLink(pageLink, completion: handler)
        }
        else {
            self.network.fetchPeople(completion: handler)
        }
    }
    
    private let carouselData: [HeaderCellContent] = [
        .init(title: "#BLACKLIVESMATTER", description: "How to get involved"),
        .init(title: "#BLACKLIVESMATTER", description: "How to get involved"),
        .init(title: "#BLACKLIVESMATTER", description: "How to get involved")
    ]
}
