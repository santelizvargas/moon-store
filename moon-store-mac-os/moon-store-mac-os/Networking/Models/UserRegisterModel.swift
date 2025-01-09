//
//  UserRegisterModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/7/25.
//

struct UserRegisterModel: Codable {
    var firstName: String = ""
    var lastName: String = ""
    var identification: String = ""
    var phone: String = ""
    var address: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    func cannotRegisterYet() -> Bool {
        firstName.isEmpty ||
        lastName.isEmpty ||
        identification.isEmpty ||
        phone.isEmpty ||
        address.isEmpty ||
        !email.matchesEmail ||
        password.isEmpty ||
        confirmPassword.isEmpty
    }
}
