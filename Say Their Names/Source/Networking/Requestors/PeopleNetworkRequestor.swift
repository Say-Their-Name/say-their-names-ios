//
//  PersonNetworkHandle.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - PersonUrl
final class PersonUrl: BaseNetworkUrl {
    class var people: UrlString { return "\(self.base)/api/people" }
}

// MARK: - PeopleNetworkRequestor<T>

typealias PeopleNetworkRequestor<T> = NetworkSession<T>
extension PeopleNetworkRequestor {
    // MARK: - Public methods
    
    public func fetchPeople(completion: @escaping (People?, STNError?) -> Swift.Void) {
        self._fetchPeopleAtUrl(PersonUrl.people, completion: completion)
    }
    
    public func fetchPeopleWithLink(_ peopleLink: PeopleLink, completion: @escaping (People?, STNError?) -> Swift.Void) {
        guard let nextUrl = peopleLink.next else {
            completion(nil, STNError(code: -12, message: "No Next URL"))
            return
        }
        
        self._fetchPeopleAtUrl(nextUrl, completion: completion)
    }
    
    // MARK: - Private methods
    
    private func _fetchPeopleAtUrl(_ url: String, completion: @escaping (People?, STNError?) -> Swift.Void) {
        let task = NetworkTask<People>(url, parse: false, requestType: .get) { STNDecoder.decode($0) }

        self.load(task) { (people, totalTime, error) in
            DispatchQueue.mainAsync { completion(people, error) }
        }
    }
}
