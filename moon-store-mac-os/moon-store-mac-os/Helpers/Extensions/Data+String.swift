//
//  Data+String.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/8/24.
//

import Foundation

extension Data {
    mutating func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
