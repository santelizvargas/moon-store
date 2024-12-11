//
//  MSError+Helper.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/9/24.
//

import Foundation

enum MSError: Error {
    case badUrl
    case badHttpRequest
    case networkConnection
    
    var localizedDescription: String {
        switch self {
            case .badUrl: "Invalid URL"
            case .badHttpRequest: "Bad http request"
            case .networkConnection: "Network connection"
        }
    }
    
    var friendlyMessage: String {
        switch self {
            case .networkConnection: "Algo salió mal, revise su conexión a internet e intente de nuevo"
            default: "Algo salió mal, intente de nuevo mas tarde"
        }
    }
}
