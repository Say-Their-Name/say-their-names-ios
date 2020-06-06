//
//  SearchNetworkRequestor.swift
//  SayTheirNames
//
//  Created by evilpenguin on 6/5/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Alamofire

// MARK: - SearchEnvironment
enum SearchEnvironment {
    static let urlString: String = { return "\(Environment.serverURLString)/api/search?query=" }()
}

// MARK: - NetworkRequestor (Search)
extension NetworkRequestor {
    // MARK: - Public methods
    
    public func searchByQuery(_ query: String, completion: @escaping (Result<SearchResponsePage, AFError>) -> Swift.Void) {
        let urlString = "\(SearchEnvironment.urlString)\(query)"
        self.fetchDecodable(urlString, completion: completion)
    }
}
