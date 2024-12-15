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
    
    func login(username: String,
               password: String) async throws {
        guard !isLoggedUser else { return }
        
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        do {
            let response = try await postData(for: MSEndpoint.login.endpoint,
                                              with: parameters)
            let loginResponse = try decoder.decode(LoginResponse.self, from: response)
            storeUser(loginResponse.data)
        } catch {
            throw MSError.badCredentials
        }
    }
    
    func logout() {
        guard let loggedUser else { return }
        store.remove(model: UserSwiftDataModel.factory(from: loggedUser))
    }
    
    private func storeUser(_ user: UserModel) {
        let model = UserSwiftDataModel.factory(from: user)
        store.save(model: model)
    }
}
