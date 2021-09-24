//
//  SampleLoginAPI.swift
//  BaseAPI
//
//  Created by HaND on 9/16/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

struct SampleLoginAPI: APIClient {
    typealias Model = SampleLoginResponse
    
    var environment: Environment {
        return DefaultEnvironment()
    }
    
    var path: String {
        return "/login"
    }
    
    var encoding: ParameterEncoding {
        return .json(params)
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var params: Parameter
}

/// Assume that Login API return response with format below
///```
/// {
///     "meta": {
///         "code": 100,
///         "message": "Wrong login ID or password",
///     }
///     "data": {
///         "access_token": "oklsdfjlkdsjf",
///         "user_id": "1423534645"
///     }
/// }
///
struct SampleLoginResponse: Decodable {
    var meta: Meta
    var data: LoginModel?
    
    enum CodingKeys: String, CodingKey {
        case meta
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        meta = try container.decode(Meta.self, forKey: .meta)
        data = try container.decodeIfPresent(LoginModel.self, forKey: .data)
        if meta.code != 0 {
            throw SampleError(code: meta.code, message: meta.message ?? "Unknown error")
        }
    }
}

struct LoginModel: Decodable {
    var accessToken: String?
    var userId: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try container.decodeIfPresent(String.self, forKey: .accessToken)
        userId = try container.decodeIfPresent(String.self, forKey: .userId)
    }
}
