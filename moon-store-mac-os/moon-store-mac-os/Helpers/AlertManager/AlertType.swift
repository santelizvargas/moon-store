//
//  AlertType.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 4/12/24.
//

import SwiftUI

enum AlertType {
    case error(String)
    case warning(String)
    case info(String)

    var title: String {
        switch self {
        case .error: return "Error"
        case .warning: return "Warning"
        case .info: return "Info"
        }
    }

    var message: String {
        switch self {
        case .error(let message), .warning(let message), .info(let message):
            return message
        }
    }

    var icon: Image {
        switch self {
        case .error: return Image(systemName: "xmark.octagon.fill")
        case .warning: return Image(systemName: "exclamationmark.triangle.fill")
        case .info: return Image(systemName: "info.circle.fill")
        }
    }
    
    var iconColor: Color {
        switch self {
            case .error: return .red
            case .warning: return .yellow
            case .info: return .blue
        }
    }
}
