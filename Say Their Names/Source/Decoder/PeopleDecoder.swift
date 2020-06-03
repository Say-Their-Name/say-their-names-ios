//
//  PersonSerialization.swift
//  Say Their Names
//
//  Created by evilpenguin on 6/3/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

final class PeopleDecoder {
    public class func decode(_ data: Any?) -> People? {
        guard let data = data as? Data else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let people = try decoder.decode(People.self, from: data)
            
            return people
        }
        catch {
            print("Unexpected error: \(error).")
        }
        
        return nil
    }
}
