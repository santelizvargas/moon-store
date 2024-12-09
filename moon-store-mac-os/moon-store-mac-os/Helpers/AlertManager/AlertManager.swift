//
//  AlertManager.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 4/12/24.
//

import AppKit

final class AlertPresenter: ObservableObject {
    @Published var isPresented: Bool = false
    
    func showAlert(type: AlertType) {
        isPresented = true
        alertConstruction(type)
    }
    
    private func alertConstruction(_ type: AlertType) {
        let alert = NSAlert()
        alert.alertStyle = type.alertType
        alert.messageText = type.title
        alert.informativeText = type.message

        if let icon = type.icon {
            alert.icon = icon
        }
        
        alert.addButton(withTitle: "OK")
        alert.runModal()
        
        isPresented = false
    }
}
