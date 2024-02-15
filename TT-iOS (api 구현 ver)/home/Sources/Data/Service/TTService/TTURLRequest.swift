//
//  TTURLRequest.swift
//  home
//
//  Created by 반성준 on 2/14/24.
//

import Foundation
import Alamofire

enum TTHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct TTURLRequest: URLRequestConvertible {
    var accessToken: String?
    var urlRequest: URLRequest
    var httpMethod: TTHTTPMethod
    var path: String
    var httpBody: Data? = nil
    var query: [String: String]? = nil
    var timeoutInterval: TimeInterval
    
    init?(_ accessToken: String? = nil,
         url: URL,
         method: TTHTTPMethod = .get,
         path: String,
         httpBody: [String: Any?]? = nil,
         query: [String: String]? = nil,
         timeoutInterval: TimeInterval = 30) {
        self.accessToken = accessToken
        self.urlRequest = URLRequest(url: url.appendingPathComponent(path, conformingTo: .url))
        self.httpMethod = method
        self.path = path
        if let httpBody = httpBody?.filter({ $0.value != nil }) {
            self.httpBody = try? JSONSerialization.data(withJSONObject: httpBody)
        }
        self.query = query
        self.timeoutInterval = timeoutInterval
    }
    
    init?(_ accessToken: String? = nil,
         url: URL,
         method: TTHTTPMethod = .get,
         path: String,
         httpBodyObject: Encodable,
         query: [String: String]? = nil,
         timeoutInterval: TimeInterval = 30) {
        self.accessToken = accessToken
        self.urlRequest = URLRequest(url: url.appendingPathComponent(path, conformingTo: .url))
        self.httpMethod = method
        self.path = path
        self.httpBody = try? JSONEncoder().encode(httpBodyObject)
        self.query = query
        self.timeoutInterval = timeoutInterval
    }
    
    /// URLRequestConvertible protocol function
    /// - Returns: URL Request
    public func asURLRequest() throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "Content-Type")
        if let accessToken = accessToken {
            urlRequest.setValue("Bearer \(accessToken)",
                                forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.httpBody = httpBody
        urlRequest.timeoutInterval = timeoutInterval
        return urlRequest
    }
}
