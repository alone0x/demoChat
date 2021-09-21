//
//  Request.swift
//  BaseAPI
//
//  Created by HaND on 9/16/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

enum ParameterEncoding {
    case url(Parameter)
    case json(Parameter)
    case formData(Parameter, File?)
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct File {
    let name: String
    let mimeType: String
    let data: Data
}

typealias Parameter = [String: Any]

protocol Request {
    var environment: Environment { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var method: HTTPMethod { get }
    var header: [String: String] { get }
    var request: URLRequest { get }
}

extension Request {
    var fullUrl: URL {
        guard let url = URL(string: environment.baseUrl) else {
            fatalError("Invalid url")
        }
        guard !path.isEmpty else {
            return url
        }
        return url.appendingPathComponent(path)
    }
    
    var header: [String: String] {
        return environment.header
    }
    
    var request: URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        if let convertedRequest = urlRequest.convert(to: encoding) {
            urlRequest = convertedRequest
        }
        for (key, value) in header {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        urlRequest.timeoutInterval = environment.timeout
        
        return urlRequest
    }
}
