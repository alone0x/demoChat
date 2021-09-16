//
//  URLRequest+Encoding.swift
//  BaseAPI
//
//  Created by HaND on 9/16/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

extension URLRequest {
    func convert(to encoding: ParameterEncoding) -> URLRequest? {
        switch encoding {
        case .url(let params):
            return urlEncode(params: params)
        case .json(let params):
            return jsonEncode(params: params)
        case .formData(let params, let file):
            return formDataEncode(params: params, file: file)
        }
    }
    
    private func urlEncode(params: Parameter) -> URLRequest? {
        guard let url = self.url else { return nil }
        var components: [(String, String)] = []
        for (key, value) in params {
            components += queryComponents(from: key, value: value)
        }
        let queryItems = components.map {
            "\($0)=\($1)"
        }
        if self.httpMethod == HTTPMethod.get.rawValue {
            var component = URLComponents(url: url, resolvingAgainstBaseURL: false)
            component?.percentEncodedQuery = queryItems.joined(separator: "&")
            guard let encodedUrl = component?.url else { return nil }
            var newRequest = URLRequest(url: encodedUrl)
            newRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            return newRequest
        } else {
            var newRequest = self
            newRequest.httpBody = queryItems.joined(separator: "&").data(using: .utf8)
            newRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            return newRequest
        }
    }
    
    private func jsonEncode(params: Parameter) -> URLRequest? {
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed)
            var newRequest = self
            newRequest.httpBody = data
            newRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return newRequest
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func formDataEncode(params: Parameter, file: File?) -> URLRequest? {
        let boundary = "Boundary-\(UUID().uuidString)"
        var newRequest = self
        newRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let httpBody = NSMutableData()
        for (key, value) in params {
            httpBody.append(convertFormField(name: key, value: "\(value)", boundary: boundary))
        }
        if let file = file {
            httpBody.append(convertFileData(file: file, boundary: boundary))
        }
        httpBody.append("--\(boundary)--")
        newRequest.httpBody = httpBody as Data
        
        return newRequest
    }
    
    private func convertFormField(name: String, value: String, boundary: String) -> String {
        var fieldStr = "--\(boundary)\r\n"
        fieldStr += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldStr += "\r\n"
        fieldStr += "\(value)\r\n"
        
        return fieldStr
    }
    
    private func convertFileData(file: File, boundary: String) -> Data {
        let data = NSMutableData()
        data.append("--\(boundary)\r\n")
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(file.name)\"\r\n")
        data.append("Content-Type: \(file.mimeType)\r\n\r\n")
        data.append(file.data)
        data.append("\r\n")
        return data as Data
    }
    
    private func queryComponents(from key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []

        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(from: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(from: "\(key)[]", value: value)
            }
        } else {
            components.append((escape(key), escape("\(value)")))
        }

        return components
    }
    
    func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        var escaped = ""

        escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string

        return escaped
    }
}
