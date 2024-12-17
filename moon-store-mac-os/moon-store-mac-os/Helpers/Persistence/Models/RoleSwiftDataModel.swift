//
//  RoleModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/14/24.
//

import SwiftData

@Model
final class RoleSwiftDataModel {
    var id: Int
    var name: String
    var desc: String
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    
    init(id: Int,
         name: String,
         desc: String,
         createdAt: String? = nil,
         updatedAt: String? = nil,
         deletedAt: String? = nil) {
        self.id = id
        self.name = name
        self.desc = desc
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
    
    static func factory(from role: RoleModel) -> RoleSwiftDataModel {
        RoleSwiftDataModel(id: role.id,
                           name: role.name,
                           desc: role.description,
                           createdAt: role.createdAt,
                           updatedAt: role.updatedAt,
                           deletedAt: role.deletedAt)
    }
}
