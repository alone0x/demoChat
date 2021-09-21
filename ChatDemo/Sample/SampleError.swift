//
//  SampleError.swift
//  BaseAPI
//
//  Created by HaND on 9/16/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

struct SampleError: Error {
    var code: Int
    var message: String
    
    var localizedDescription: String {
        return message
    }
}
