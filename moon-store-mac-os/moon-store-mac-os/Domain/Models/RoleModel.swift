//
//  RoleModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/14/24.
//

struct RoleModel: Decodable {
    let id: Int
    let name: String
    let description: String
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    
    func copyWith(name: String? = nil,
                  description: String? = nil) -> RoleModel {
        RoleModel(id: id,
                  name: name ?? self.name,
                  description: description ?? self.description,
                  createdAt: createdAt,
                  updatedAt: updatedAt,
                  deletedAt: deletedAt)
    }
    
    static func factory(from role: RoleSwiftDataModel) -> RoleModel {
        RoleModel(id: role.id,
                  name: role.name,
                  description: role.desc,
                  createdAt: role.createdAt,
                  updatedAt: role.updatedAt,
                  deletedAt: role.deletedAt)
    }
}
