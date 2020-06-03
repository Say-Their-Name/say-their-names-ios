//
//  PersonNetworkHandle.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/2/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - ConfigUrl
final class PersonUrl: BaseNetworkUrl {
    class var people: UrlString { return "\(self.base)/api/people" }
}

// MARK: - ConfigNetworkHandle<T>
typealias PersonNetworkHandle<T> = NetworkSession<T>
extension PersonNetworkHandle {
    public func fetchAllPeople<P: Person>(completion: @escaping ([P]?, NetworkError?) -> Swift.Void) {
        let task = NetworkTask<Array<P>>(PersonUrl.people, requestType: .get) { (dictionary) in
            guard let dictionary = dictionary as? Dictionary<String, Any>,
                  let data = dictionary["data"] as? Array<Dictionary<String, Any>>
            else { return nil }
            
            var people = [P]()
            for person in data {
                let person = P.init(person as Serialization.DictionaryType)
                people.append(person)
            }
            return people
        }

        self.load(task) { (people, totalTime, error) in
            DispatchQueue.mainAsync { completion(people, error) }
        }
    }
}
