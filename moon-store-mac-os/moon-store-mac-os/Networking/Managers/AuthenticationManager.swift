//
//  AuthenticationManager.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/8/25.
//

import Foundation

final class AuthenticationManager {
    private let networkManager: NetworkManager = .init()
    private let decoder: JSONDecoder = .init()
    private let userStore: DataManager<UserModel> = .init()
    
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
    
    // MARK: - Login
    
    func login(email: String, password: String) async throws {
        guard !isLoggedUser else { return }
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        do {
            let response = try await networkManager.postData(for: .login, with: parameters)
            let loginResponse = try decoder.decode(LoginResponseModel.self, from: response)
            try storeUser(loginResponse.user)
        } catch {
            throw error
        }
    }
    
    // MARK: - Logout
    
    func logout() {
        guard loggedUser != nil else { return }
        
        do {
            try userStore.removeAll()
        } catch {
            AlertPresenter.showAlert(with: error)
        }
    }
    
    private func storeUser(_ user: UserModel) throws {
        do {
            try userStore.save(model: user)
        } catch {
            throw error
        }
    }
}
