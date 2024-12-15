//
//  User.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/14/24.
//

struct LoginResponse: Decodable {
    let accessToken: String
    let expiresIn: Int
    let data: UserModel
}

struct UserModel: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let identification: String
    let phone: String
    let address: String
    var roles: [RoleModel]
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
    
    func copyWith(firstName: String? = nil,
                  lastName: String? = nil,
                  email: String? = nil,
                  identification: String? = nil,
                  phone: String? = nil,
                  address: String? = nil,
                  roles: [RoleModel]? = nil) -> UserModel {
        UserModel(id: id,
                  firstName: firstName ?? self.firstName,
                  lastName: lastName ?? self.lastName,
                  email: email ?? self.email,
                  identification: identification ?? self.identification,
                  phone: phone ?? self.phone,
                  address: address ?? self.address,
                  roles: roles ?? self.roles,
                  createdAt: createdAt,
                  updatedAt: updatedAt,
                  deletedAt: deletedAt)
    }
    
    static func factory(from user: UserSwiftDataModel) -> UserModel {
        UserModel(id: user.id,
                  firstName: user.firstName,
                  lastName: user.lastName,
                  email: user.email,
                  identification: user.identification,
                  phone: user.phone,
                  address: user.address,
                  roles: user.roles.map { RoleModel.factory(from: $0) },
                  createdAt: user.createdAt,
                  updatedAt: user.updatedAt,
                  deletedAt: user.deletedAt)
    }
}
