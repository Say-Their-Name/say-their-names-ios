//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - NetworkSessionMock
typealias NetworkSessionMock<T> = NetworkSession<T>
extension NetworkSessionMock {
    public class func loadMock<T>(_ download: NetworkTask<T>, completion: @escaping (T?, TimeInterval, NetworkError?) -> Swift.Void) {
//        guard let modelClass = T.self as? BaseModel.Type else { return }
//
//        let time = Date()
//        let (result, networkError) = download.parse(modelClass.mockJson(), nil, nil)
//        completion(result, Date().timeIntervalSince(time), networkError)
    }
}
