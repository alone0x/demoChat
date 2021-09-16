//
//  SamplePostTodo.swift
//  BaseAPI
//
//  Created by HaND on 9/16/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

struct SampleCreatePostAPI: APIClient {
    typealias Model = Post
    
    var environment: Environment {
        return DefaultEnvironment()
    }

    var path: String {
        return "/posts"
    }
    
    var encoding: ParameterEncoding {
        return .json(params)
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    let params: Parameter
}

struct Post: Decodable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case body
        case userId
    }
}
