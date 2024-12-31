//
//  AlertManager.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 4/12/24.
//

import AppKit

final class AlertPresenter {
    
    private init() { }
    
    static func showAlert(type: AlertType = .info, alertMessage: String) {
        let alert = NSAlert()
        alert.messageText = type.title
        alert.informativeText = alertMessage
        
        alert.icon = NSImage(named: type.icon)
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    static func showAlert(with error: Error) {
        var friendlyMessage: String {
            guard let msError = error as? MSError else {
                return "Algo salió mal. Por favor, intenta más tarde."
            }
            
            return msError.friendlyMessage
        }
        
        debugPrint("An Error occurred: \(error.localizedDescription)")
        AlertPresenter.showAlert(type: .error, alertMessage: friendlyMessage)
    }
}
