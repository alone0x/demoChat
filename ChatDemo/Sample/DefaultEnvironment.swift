//
//  DefaultEnvironment.swift
//  BaseAPI
//
//  Created by HaND on 9/16/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

struct DefaultEnvironment: Environment {
    var baseUrl: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var timeout: TimeInterval {
        return 30
    }
    
    var header: [String : String] {
        return [:]
    }
}
