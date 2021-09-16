//
//  APIOperation.swift
//  BaseAPI
//
//  Created by HaND on 9/15/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

typealias APIClient = APIOperation & Request

protocol APIOperation {
    associatedtype Model: Decodable
    var session: URLSession { get }
    var showIndicator: Bool { get }
    func execute(file: String, function: String, completion: @escaping (Result<Model, APIError>) -> Void)
}

extension APIOperation where Self: Request {
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }
    var showIndicator: Bool {
        return true
    }
    func execute(file: String = #file, function: String = #function, completion: @escaping (Result<Model, APIError>) -> Void) {
        if showIndicator {
            // TODO: Show Indicator
        }
        let dataTask = session.dataTask(with: self.request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                if showIndicator {
                    // TODO: Hide Indicator
                }
                if let error = error {
                    completion(.failure(APIError.networkError))
                    return
                }
                guard let data = data else {
                    completion(.failure(APIError.invalidResponse))
                    return
                }
                do {
                    let dataModel = try JSONDecoder().decode(Model.self, from: data)
                    completion(.success(dataModel))
                } catch let error {
                    if let apiError = error as? APIError {
                        completion(.failure(apiError))
                    } else {
                        completion(.failure(APIError.decodeFail))
                    }
                }
            }
        })
        dataTask.resume()
    }
}
