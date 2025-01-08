//
//  RegisterUserViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/7/25.
//

import Foundation

final class RegisterUserViewModel: ObservableObject {
    @Published var userModel: UserRegisterModel = .init()
    @Published var wasRegisterSuccess: Bool = false
    @Published var isLoading: Bool = false
    
    var cannotRegisterYet: Bool {
        userModel.cannotRegisterYet()
    }
    
    private let authenticationManager: UserManager = .init()
    
    func registerUser() {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                try await authenticationManager.registerUser(user: userModel)
                userModel = UserRegisterModel()
                AlertPresenter.showAlert("Usuario registrado exitosamente!")
                wasRegisterSuccess = true
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
}
