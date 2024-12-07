//
//  AlertManager.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 4/12/24.
//

import Foundation

class AlertManager: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var alertType: AlertType? = nil
    
    func showAlert(type: AlertType) {
        alertType = type
        isPresented = true
    }
    
    func hideAlert() {
        isPresented = false
    }
}
