//
//  LoginRepository.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/14/24.
//

import Foundation

final class AuthenticationRepository: BaseNetworkService {
    private let userStore: DataManager<UserModel> = .init()
    
    var loggedUser: UserModel? {
        do {
            let users = try userStore.fetch()
            return users.first
        } catch {
            debugPrint("Error: User not found \(error.localizedDescription) redirect to login")
            return nil
        }
    }
    
    // MARK: - Methods
    
    func login(email: String, password: String) async throws {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        do {
            let data = try await postData(for: MSEndpoint.login.path,
                                              with: parameters)
            let decodedObject = try JSONDecoder().decode(
                LoginResponseModel.self,
                from: data
            )
            try userStore.save(model: decodedObject.user)
        } catch {
            throw error
        }
    }
    
    func logout() throws {
        guard loggedUser != nil else { return }
        
        do {
            try userStore.removeAll()
        } catch {
            throw error
        }
    }
}
