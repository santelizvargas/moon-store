//
//  AlertManager.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 4/12/24.
//

import AppKit

final class AlertManager: ObservableObject {
    @Published var isPresented: Bool = false
    
    func showAlert(type: AlertType) {
        isPresented = true
        alertConstruction(type)
    }
    
    private func alertConstruction(_ alertType: AlertType) {
        let alert = NSAlert()
        alert.alertStyle = .informational
        alert.messageText = alertType.title
        alert.informativeText = alertType.message

        if let icon = alertType.icon {
            alert.icon = icon
        }
        
        alert.addButton(withTitle: "OK")
        alert.runModal()
        
        isPresented = false
    }
}
