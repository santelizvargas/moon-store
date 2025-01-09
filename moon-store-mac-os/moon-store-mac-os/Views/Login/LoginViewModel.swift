//
//  LoginViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/15/24.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var loggedUser: UserModel?
    
    private let authenticationManager: AuthenticationManager = .init()
    
    init() {
        loggedUser = authenticationManager.loggedUser
    }
    
    func login() {
        isLoading = true
        
        Task { @MainActor in
            defer {
                isLoading = false
                loggedUser = authenticationManager.loggedUser
            }
            
            do {
                try await authenticationManager.login(email: email,
                                                      password: password)
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
    
    func logout() {
        authenticationManager.logout()
    }
}
