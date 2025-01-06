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
}
