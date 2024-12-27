//
//  AuthenticationManager.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 18/12/24.
//

import Foundation

final class AuthenticationManager {
    private let authRepository: AuthenticationRepository
    
    init(authRepository: AuthenticationRepository = .init()) {
        self.authRepository = authRepository
    }
    
    func logout() {
        do {
            try authRepository.logout()
        } catch {
            presentError(error)
        }
    }
    
    private func presentError(_ error: Error) {
        let userFriendlyMessage: String = {
            guard let msError = error as? MSError else {
                return "An unexpected error occurred. Please try again."
            }
            return msError.friendlyMessage
        }()
        
        AlertPresenter.showAlert(type: .error,
                                 alertMessage: userFriendlyMessage)
        debugPrint("Error occurred: \(error.localizedDescription)")
    }
}
