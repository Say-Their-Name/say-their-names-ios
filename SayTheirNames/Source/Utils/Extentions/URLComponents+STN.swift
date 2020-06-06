//
//  URLComponents+Stn.swift
//  SayTheirNames
//
//  Created by evilpenguin on 6/5/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

extension URLComponents {
    init?(string: String, item: URLQueryItem) {
        self.init(string: string)
        self.queryItems = [item]
    }
}
