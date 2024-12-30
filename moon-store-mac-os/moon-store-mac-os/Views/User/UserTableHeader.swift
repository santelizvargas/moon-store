//
//  UserTableHeader.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 30/12/24.
//

enum UserTableHeader: CaseIterable {
    case icon, user, email, role, date, option
    
    var title: String {
        switch self {
            case .user: "Usuario"
            case .email: "Email"
            case .role: "Rol"
            case .date: "Fecha"
            default: ""
        }
    }
}
