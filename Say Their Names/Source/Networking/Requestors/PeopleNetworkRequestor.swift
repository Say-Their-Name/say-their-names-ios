//
//  PersonNetworkHandle.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - PersonUrl
final class PersonUrl: BaseNetworkUrl {
    class var people: UrlString { return "\(self.base)/api/people" }
}

// MARK: - PeopleNetworkRequestor
typealias PeopleNetworkRequestor = NetworkRequestor
extension PeopleNetworkRequestor {
    // MARK: - Public methods
    
    public func fetchPeople(completion: @escaping (People?) -> Swift.Void) {
        self._fetchPeopleAtUrl(PersonUrl.people, completion: completion)
    }
    
    public func fetchPeopleWithLink(_ peopleLink: PeopleLink, completion: @escaping (People?) -> Swift.Void) {
        guard let nextUrl = peopleLink.next else {
            completion(nil)
            return
        }
        
        self._fetchPeopleAtUrl(nextUrl, completion: completion)
    }
    
    // MARK: - Private methods
    
    private func _fetchPeopleAtUrl(_ url: String, completion: @escaping (People?) -> Swift.Void) {
        let request = AF.request(url)
        request.responseDecodable(of: People.self) { (response) in
          completion(response.value)
        }
    }
}
