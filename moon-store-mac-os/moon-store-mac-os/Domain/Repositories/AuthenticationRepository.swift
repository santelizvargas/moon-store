//
//  LoginRepository.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/14/24.
//

import Foundation

final class AuthenticationRepository: BaseNetworkService {
    private let decoder: JSONDecoder = .init()
    private let userStore: DataManager<UserModel> = .init()
    
    var isLoggedUser: Bool { loggedUser != nil }
    
    var loggedUser: UserModel? {
        let user: UserModel?
        
        do {
            user = try userStore.fetch().first
        } catch {
            debugPrint("Error: User not found \(error.localizedDescription) redirect to login")
        }
        
        return user
    }
    
    // MARK: - Methods
    
    func login(email: String,
               password: String) async throws {
        guard !isLoggedUser else { return }
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        do {
            let response = try await postData(for: MSEndpoint.login.path,
                                              with: parameters)
            let loginResponse = try decoder.decode(LoginResponseModel.self, from: response)
            try storeUser(loginResponse.data)
        } catch let error as MSError {
            throw error
        }
    }
    
    func logout() throws {
        guard loggedUser != nil else { return }
        
        do {
            try userStore.removeAll()
            try userStore.saveChanges()
        } catch let error as MSError {
            throw error
        }
    }
    
    private func storeUser(_ user: UserModel) throws {
        store.save(model: user)
        return try userStore.saveChanges()
    }
}
