//
//  RoleModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/14/24.
//

import SwiftData

@Model
final class RoleModel: Decodable {
    var id: Int
    var name: String
    var desc: String
    var createdAt: String?
    var updatedAt: String?
    var deletedAt: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case createdAt
        case updatedAt
        case deletedAt
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        desc = try container.decode(String.self, forKey: .desc)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try container.decodeIfPresent(String.self, forKey: .updatedAt)
        deletedAt = try container.decodeIfPresent(String.self, forKey: .deletedAt)
    }
    
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
}
