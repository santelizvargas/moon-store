//
//  UserModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/14/24.
//

import SwiftData

@Model
final class UserModel: Decodable {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var identification: String
    var phone: String
    var address: String
    var roles: [RoleModel]
    var createdAt: String
    var updatedAt: String?
    var deletedAt: String?
    
    init(id: Int,
         firstName: String,
         lastName: String,
         email: String,
         identification: String,
         phone: String,
         address: String,
         roles: [RoleModel],
         createdAt: String,
         updatedAt: String? = nil,
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
    
    // MARK: - Decoder
    
    private enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case email
        case identification
        case phone
        case address
        case roles
        case createdAt
        case updatedAt
        case deletedAt
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.email = try container.decode(String.self, forKey: .email)
        self.identification = try container.decode(String.self, forKey: .identification)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.address = try container.decode(String.self, forKey: .address)
        self.roles = try container.decode([RoleModel].self, forKey: .roles)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        self.deletedAt = try container.decodeIfPresent(String.self, forKey: .deletedAt)
    }
}
