//
//  MSError+Helper.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/9/24.
//

import Foundation

enum MSError: Error {
    
    // Https
    case badURL
    case badHttpRequest
    case networkConnection
    
    // Storage
    case notSaved
    case notFound
    case notDeleted
    case badData
    case badKey
    case duplicateKey
    
    // Authentication
    case badCredentials
    case userNotFound
    
    // Codable
    case encodingError
    case decodingError

    var friendlyMessage: String {
        switch self {
        case .badHttpRequest: "Hubo un problema con la solicitud. Por favor, inténtalo de nuevo."
        case .networkConnection: "Por favor, verifica tu conexión a internet e inténtalo de nuevo."
        case .badCredentials, .userNotFound:
                "Las credenciales son incorrectas. Por favor, inténtalo de nuevo."
        case .duplicateKey: "El nombre ya existe, por favor ingrese uno diferente."
        default: "Algo salió mal. Por favor, intenta más tarde."
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .badURL: "Invalid URL format"
        case .badHttpRequest: "HTTP request failed due to malformed request"
        case .networkConnection: "Network connection error"
        case .notSaved: "Data could not be saved to storage"
        case .notFound: "Data not found in storage"
        case .notDeleted: "Data not deleted in storage"
        case .badData: "Corrupt or malformed data"
        case .badKey: "Invalid key for data retrieval"
        case .badCredentials: "Incorrect user credentials provided"
        case .userNotFound: "User not found in the database"
        case .encodingError: "Encoding error occurred"
        case .decodingError: "Decoding error occurred"
        case .duplicateKey: "Duplicate key"
        }
    }
}
