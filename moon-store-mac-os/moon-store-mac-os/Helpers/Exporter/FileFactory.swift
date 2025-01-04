//
//  FileFactory.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 3/1/25.
//

final class FileFactory {
    static func makeUserStringFormatted(users: [UserModel]) -> String {
        let header = "Nombre, Email, Roles"
        
        let formattedUsers = users.map { user in
            let role = user.roles.first?.name ?? "-"
            return "\(user.firstName), \(user.email), \(role)"
        }.joined(separator: "\n")
        
        return [header, formattedUsers].joined(separator: "\n")
    }
}
