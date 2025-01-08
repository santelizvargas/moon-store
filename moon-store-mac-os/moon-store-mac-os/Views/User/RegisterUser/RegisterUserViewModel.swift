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
        userModel.cannotRegisterYet() ||
        userModel.password != userModel.confirmPassword
    }
    
    private let userManager: UserManager = .init()
    
    func registerUser() {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                try await userManager.registerUser(user: userModel)
                AlertPresenter.showAlert("Usuario registrado exitosamente!")
                userModel = UserRegisterModel()
                wasRegisterSuccess = true
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
}
