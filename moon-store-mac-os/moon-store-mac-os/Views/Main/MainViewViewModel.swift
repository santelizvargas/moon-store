//
//  MainViewViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/15/24.
//

import Foundation

final class MainViewViewModel: ObservableObject {
    private let authenticationRepository: AuthenticationRepository = .init()
    
    func logout() {
        do {
            try authenticationRepository.logout()
        } catch {
            guard let error = error as? MSError else { return }
            AlertPresenter().showAlert(type: .error, alertMessage: error.friendlyMessage)
        }
    }
}
