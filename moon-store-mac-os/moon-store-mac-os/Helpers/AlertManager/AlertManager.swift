//
//  AlertManager.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 4/12/24.
//

import AppKit

final class AlertPresenter {
    
    private init() { }
    
    static func showAlert(type: AlertType, alertMessage: String) {
        let alert = NSAlert()
        alert.messageText = type.title
        alert.informativeText = alertMessage
        
        alert.icon = NSImage(named: type.icon)
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}
