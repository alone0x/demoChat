//
//  NSMutableData+Extension.swift
//  BaseAPI
//
//  Created by HaND on 9/16/20.
//  Copyright © 2020 Rikkeisoft. All rights reserved.
//

import Foundation

extension NSMutableData {
    func append(_ value: String) {
        if let data = value.data(using: .utf8) {
            self.append(data)
        }
    }
}
