//
//  LoginRepository.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/14/24.
//

import Foundation

final class AuthenticationRepository: BaseNetworkService {
    var loggedUser: UserModel? {
        guard let storedUser = try? store.fetch().first else { return nil }
        return UserModel.factory(from: storedUser)
    }
    
    var isLoggedUser: Bool { loggedUser != nil }
    
    private let decoder: JSONDecoder = .init()
    private let store: DataManager<UserSwiftDataModel> = .init()
    
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
            let loginResponse = try decoder.decode(LoginResponse.self, from: response)
            try storeUser(loginResponse.data)
        } catch let error as MSError {
            throw error
        }
    }
    
    func logout() throws {
        guard let _ = loggedUser else { return }
        
        do {
            try store.removeAll()
            try store.storeChanges()
        } catch let error as MSError {
            throw error
        }
    }
    
    private func storeUser(_ user: UserModel) throws {
        let model = UserSwiftDataModel.factory(from: user)
        store.save(model: model)
        return try store.storeChanges()
    }
}
