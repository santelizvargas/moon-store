//
//  UserModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/14/24.
//

import SwiftData

@Model
final class UserSwiftDataModel {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var identification: String
    var phone: String
    var address: String
    var roles: [RoleSwiftDataModel]
    var createdAt: String
    var updatedAt: String
    var deletedAt: String?
    
    init(id: Int,
         firstName: String,
         lastName: String,
         email: String,
         identification: String,
         phone: String,
         address: String,
         roles: [RoleSwiftDataModel],
         createdAt: String,
         updatedAt: String,
         deletedAt: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.identification = identification
        self.phone = phone
        self.address = address
        self.roles = roles
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
    
    static func factory(from user: UserModel) -> UserSwiftDataModel {
        UserSwiftDataModel(id: user.id,
                           firstName: user.firstName,
                           lastName: user.lastName,
                           email: user.email,
                           identification: user.identification,
                           phone: user.phone,
                           address: user.address,
                           roles: user.roles.map { RoleSwiftDataModel.factory(from: $0) },
                           createdAt: user.createdAt,
                           updatedAt: user.updatedAt,
                           deletedAt: user.deletedAt)
    }
}
