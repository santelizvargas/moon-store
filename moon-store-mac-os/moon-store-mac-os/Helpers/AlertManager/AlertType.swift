//
//  AlertType.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 4/12/24.
//

import AppKit

enum AlertType {
    case error(String)
    case warning(String)
    case info(String)

    var title: String {
        switch self {
        case .error: "Error"
        case .warning: "Warning"
        case .info: "Info"
        }
    }

    var message: String {
        switch self {
        case .error(let message), .warning(let message), .info(let message): message
        }
    }

    var icon: NSImage? {
        switch self {
            case .error: NSImage(resource: .error)
            case .warning: NSImage(named: NSImage.cautionName)
            case .info: NSImage(named: NSImage.infoName)
        }
    }
    
    var alertType: NSAlert.Style {
        switch self {
            case .error: .critical
            case .warning: .warning
            case .info: .informational
        }
    }
}
