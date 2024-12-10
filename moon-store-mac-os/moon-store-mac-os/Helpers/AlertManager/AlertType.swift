//
//  AlertType.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 4/12/24.
//

import AppKit

enum AlertType {
    case error
    case warning
    case info

    var title: String {
        switch self {
        case .error: "Error"
        case .warning: "Warning"
        case .info: "Info"
        }
    }

    var icon: String {
        switch self {
            case .error: "error"
            case .warning: NSImage.cautionName
            case .info: NSImage.infoName
        }
    }
}
