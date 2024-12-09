//
//  SwiftDataError.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 6/12/24.
//

import Foundation

// MARK: - Data Manager Error

enum SwiftDataError: Error {
    case fetchModels
    case removeModel
    
    var description: String {
        switch self {
            case .fetchModels: "Not data"
            case .removeModel: "Data doesn't exist"
        }
    }
}
