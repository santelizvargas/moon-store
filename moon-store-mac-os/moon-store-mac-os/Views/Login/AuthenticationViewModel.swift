//
//  LoginViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/15/24.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var loginSuccess: Bool = false
    
    private let authenticationRepository: AuthenticationRepository = .init()
    
    func login() {
        isLoading = true
        Task { @MainActor in
            defer {
                isLoading = false
                loginSuccess = authenticationRepository.isLoggedUser
            }
            do {
                try await authenticationRepository.login(email: email,
                                                         password: password)
            } catch let error as MSError {
                AlertPresenter().showAlert(type: .error,
                                           alertMessage: error.friendlyMessage)
            }
        }
    }
}
