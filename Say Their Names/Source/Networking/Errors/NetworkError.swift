//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//
import UIKit

// MARK: - NetworkError
class NetworkError: STNError {
    private var error: Error?
    public var type: NetworkErrorType
    
    init?(_ error: Error?, type: NetworkErrorType = .normal) {
        self.error = error
        self.type = type
        
        guard let _ = error else { return nil }
        super.init()
    }
    
    init?(fromData: Serialization.AnyType?, type: NetworkErrorType = .normal) {
        self.type = type
        
        guard let data = fromData as? Serialization.DictionaryType else { return nil }
        guard let errors = data["errors"] as? [[String:Any]], let errorDict = errors.first else { return nil }

        super.init()
        self.message = errorDict.subscriptObject("message", defaults: nil)
        self.code = errorDict.subscriptObject("code", defaults: 0)
    }
    
    init?(string: String, code: Int, type: NetworkErrorType = .normal) {
        self.type = type
        
        super.init()
        self.message = string
        self.code = code
    }
    
    override var description : String {
        return """
        NetworkError
        Code: \(String(describing: self.code))
        Message: \(String(describing: self.message))
        """
    }
}

// MARK: - NetworkErrorType
enum NetworkErrorType: Int {
    case unknown
    case normal
}
