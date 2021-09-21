//
//  APIError.swift
//  BaseAPI
//
//  Created by HaND on 9/16/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

struct APIError: Error {
    let code: Int
    private let message: String?
    
    init(code: Int, message: String?) {
        self.code = code
        self.message = message
    }
    
    var localizedDescription: String {
        return message ?? "Unknown"
    }
}

extension APIError: Equatable {
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        return lhs.code == rhs.code
    }
}

// Defined error
extension APIError {
    static let invalidResponse = APIError(code: -1, message: "system_error")
    static let decodeFail = APIError(code: -2, message: "system_error")
    static let networkError = APIError(code: -3, message: "network_error")
    static let unknown = APIError(code: -100, message: "system_error")
    static let invalidRequest = APIError(code: -4, message: "system_error")
    static let uploadFail = APIError(code: -5, message: "upload_fail")
}
