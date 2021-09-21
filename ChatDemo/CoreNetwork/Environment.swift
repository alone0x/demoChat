//
//  Environment.swift
//  BaseAPI
//
//  Created by HaND on 9/15/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

protocol Environment {
    var baseUrl: String { get }
    var timeout: TimeInterval { get }
    var header: [String: String] { get }
}
