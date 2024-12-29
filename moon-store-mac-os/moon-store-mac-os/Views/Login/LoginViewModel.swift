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
    @Published var loginSuccess: Bool = false
    
    var isLoggedUser: Bool {
        loggedUser != nil
    }
    
    var loggedUser: UserModel? {
        do {
            let users = try userStore.fetch()
            return users.first
        } catch {
            debugPrint("Error: User not found \(error.localizedDescription) redirect to login")
            return nil
        }
    }
    
    private let networkManager: NetworkManager = .init()
    private let userStore: DataManager<UserModel> = .init()
    private let decoder: JSONDecoder = .init()
    
    // MARK: - Login
    
    func login() {
        guard !isLoggedUser else { return }
        
        isLoading = true
        
        Task { @MainActor in
            defer {
                isLoading = false
                loginSuccess = isLoggedUser
                if loginSuccess { resetTextFields() }
            }
            
            let parameters: [String: Any] = [
                "email": email,
                "password": password
            ]
            
            do {
                let response = try await networkManager.postData(for: .login, with: parameters)
                let loginResponse = try decoder.decode(LoginResponseModel.self, from: response)
                try storeUser(loginResponse.data)
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
    
    // MARK: - Logout
    
    func logout() {
        guard loggedUser != nil else { return }
        
        do {
            try userStore.removeAll()
            try userStore.saveChanges()
        } catch {
            AlertPresenter.showAlert(with: error)
        }
    }
    
    private func storeUser(_ user: UserModel) throws {
        userStore.save(model: user)
        
        do {
            try userStore.saveChanges()
        } catch {
            throw error
        }
    }
    
    private func resetTextFields() {
        email = ""
        password = ""
    }
    
}
