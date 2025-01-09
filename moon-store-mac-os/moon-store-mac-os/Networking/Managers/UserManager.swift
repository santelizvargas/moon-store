//
//  UserManager.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/5/25.
//

import Foundation

final class UserManager {
    private let networkManager: NetworkManager = .init()
    private let decoder: JSONDecoder = .init()
    
    // MARK: - Get users
    
    func getUsers() async throws -> [UserModel] {
        do {
            let data = try await networkManager.getData(for: .users)
            let response = try decoder.decode(UserResponse.self, from: data)
            return response.users
        } catch {
            throw error
        }
    }
    
    // MARK: - Update password
    
    func updatePassword(email: String,
                        currentPassword: String,
                        newPassword: String,
                        confirmPassword: String) async throws {
        if currentPassword == newPassword {
            throw MSError.duplicatePassword
        } else if newPassword != confirmPassword {
            throw MSError.passwordsNotMatch
        }
        
        let parameters: [String: Any] = [
            "email": email,
            "currentPassword": currentPassword,
            "password": newPassword,
            "confirmPassword": confirmPassword
        ]
        
        do {
            try await networkManager.putData(for: .updatePassword,
                                             with: parameters)
        } catch {
            throw MSError.invalidPassword
        }
    }
    
    // MARK: - Enable User
    
    func enableUser(id: Int) async throws {
        let parameters: [String: Any] = [
            "id": id
        ]
        
        do {
            try await networkManager.putData(for: .enableUser,
                                             with: parameters)
        } catch {
            throw error
        }
    }
    
    // MARK: - Disable User
    
    func disableUser(id: Int) async throws {
        let parameters: [String: Any] = ["id": id]
        
        do {
            try await networkManager.deleteData(for: .disableUser,
                                                 with: parameters)
        } catch {
            throw error
        }
    }
    
    // MARK: - Assign Role
    
    func assignRole(role: String, email: String, revoke: Int) async throws {
        let parameters: [String: Any] = [
            "email": email,
            "role": role
        ]
        
        do {
            try await networkManager.postData(for: .roles,
                                              with: parameters)
            try await revokeRole(id: revoke, email: email)
        } catch {
            throw error
        }
    }
    
    // MARK: - Revoke Role
    
    private func revokeRole(id: Int, email: String) async throws {
        let parameters: [String: Any] = [
            "email": email,
            "roleId": id
        ]
        
        do {
            try await networkManager.deleteData(for: .roles,
                                                 with: parameters)
        } catch {
            throw error
        }
    }
    
    func registerUser(user: UserRegisterModel) async throws -> UserModel {
        do {
            let parameters = try networkManager.convertToDictionary(data: user)
            let data = try await networkManager.postData(for: .register,
                                                         with: parameters)
            let response = try decoder.decode(LoginResponseModel.self, from: data)
            return response.user
        } catch {
            throw error
        }
    }
}
