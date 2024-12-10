//
//  AlertManager.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 4/12/24.
//

import AppKit

final class AlertPresenter: ObservableObject {
    @Published var isPresented: Bool = false
    
    func showAlert(type: AlertType, alertMessage: String) {
        isPresented = true
        alertConstruction(type: type, message: alertMessage)
    }
    
    private func alertConstruction(type: AlertType, message: String) {
        let alert = NSAlert()
        alert.messageText = type.title
        alert.informativeText = message
        
        alert.icon = NSImage(named: type.icon)
        alert.addButton(withTitle: "OK")
        alert.runModal()
        
        isPresented = false
    }
}
