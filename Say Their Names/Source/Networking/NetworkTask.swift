//
//  Say Their Names
//
//  Created by evilpenguin.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

// MARK: - NetworkTaskTypes
public struct NetworkTaskTypes<T> {
    typealias Convert = (Any?) -> T?
    typealias Headers = [String: String]
}

// MARK: - NetworkTaskHttp
public struct NetworkTaskHttp {
    enum Method: String {
        case get    = "GET"
        case post   = "POST"
        case put    = "PUT"
        case delete = "DELETE"
    }
}

// MARK: - NetworkTask
public class NetworkTask<T>: NSObject {
    let url: URL?
    let requestType: NetworkTaskHttp.Method
    let parse: (Data?, Error?, URLResponse?) -> (T?, NetworkError?)
    
    var body: Any?
    weak var urlSessionTask: URLSessionTask?
    var headers: NetworkTaskTypes<T>.Headers?
    var authRequired: Bool = false
    
    convenience init(imageUrl: String, convert: @escaping NetworkTaskTypes<T>.Convert) {
        self.init(imageUrl, parse: false, convert: convert)
    }

    init(_ url: String = "", parse: Bool = true, requestType: NetworkTaskHttp.Method = .get, convert: NetworkTaskTypes<T>.Convert? = nil) {
        self.url = URL(string: url)
        self.requestType = requestType
        
        self.parse = {
            // Return type
            var returnValue:(T?, NetworkError?) = (nil, NetworkError($1))
            
            // Check for data
            guard let data = $0 else { return returnValue }
            
            // Check for response
            guard let response = $2 as? HTTPURLResponse else { return returnValue }
            
            // Log some information
            Log.print("""
            Network Response:
                Url: \(String(describing: response.url))
                Status Code: \(response.statusCode)
                Body Length: \(String(describing: data))
                Body: \(String(describing: data.toString()))
            """)
            
            // Check for a status code of 200
            if response.statusCode == 200 {
                if let convert = convert {
                    // Parse
                    if parse {
                        let result = try? Serialization.jsonObject(with: data)
                        
                        if let networkError = NetworkError(fromData: result) { returnValue.1 = networkError }
                        else { returnValue.0 = convert(result) }
                    }
                    
                    // Convert
                    else {
                        returnValue.0 = convert(data)
                    }
                }
            }
            else {
                // Turn whatever we got back into a string
                if let requestString = data.toString() {
                    // Do we have an errors dictionary
                    if requestString.range(of: "errors") != nil {
                        returnValue.1 = NetworkError(fromData: data)
                    }
                    else {
                        returnValue.1 = NetworkError(string: requestString, code: response.statusCode)
                    }
                }
            }
            
            return returnValue
        }
    }
    
    var urlRequest: URLRequest? {
        get {
            guard let url = self.url else { return nil }
            
            var request = URLRequest(url: url)
            request.httpShouldHandleCookies = false
            request.timeoutInterval = 20.0
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            
            // Add headers
            if let headers = self.headers {
                for (key, value) in headers {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }
            
            // Add body and method
            if self.requestType != .get {
                request.httpMethod = self.requestType.rawValue
                
                if let body = body {
                    request.httpBody = self._handleBodyBaseOnType(body)
                }
            }
            
            return request
        }
    }
}

// MARK: - Private methods
fileprivate extension NetworkTask {
     func _handleBodyBaseOnType(_ data: Any) -> Data? {
        if data is Serialization.DictionaryType || data is Serialization.ArrayType {
            return try? Serialization.data(withJSONObject: data)
        }
        else if data is Serialization.StringType {
            return (data as! Serialization.StringType).data(using: .utf8)
        }
        else if data is Serialization.DataType {
            return (data as! Serialization.DataType)
        }
        
        return nil
    }
}
