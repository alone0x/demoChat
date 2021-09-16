//
//  SampleTodoAPI.swift
//  BaseAPI
//
//  Created by HaND on 9/16/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

struct SampleTodoAPI: APIClient {
    typealias Model = Todo
    
    var environment: Environment {
        return DefaultEnvironment()
    }
    
    var path: String {
        return "/todos/\(id)"
    }
    
    var encoding: ParameterEncoding {
        .url([:])
    }
    
    var method: HTTPMethod {
        .get
    }
    
    let id: Int
}

struct Todo: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case completed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try container.decode(Int.self, forKey: .userId)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        completed = try container.decode(Bool.self, forKey: .completed)
    }
}
