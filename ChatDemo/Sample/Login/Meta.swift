//
//  Meta.swift
//  BaseAPI
//
//  Created by HaND on 9/16/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

struct Meta: Decodable {
    var code: Int
    var message: String?
    var count: Int?
}
