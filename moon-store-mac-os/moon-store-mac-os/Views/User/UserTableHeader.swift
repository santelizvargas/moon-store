//
//  UserTableHeader.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 30/12/24.
//

import SwiftUI

enum UserTableHeader: CaseIterable, Identifiable {
    case user, email, role, date, option
    
    var id: UserTableHeader { self }
    
    var title: String {
        switch self {
            case .user: "Usuario"
            case .email: "Email"
            case .role: "Rol"
            case .date: "Fecha"
            default: ""
        }
    }
    
    var aligment: Alignment {
        switch self {
            case .role, .date: .center
            default: .leading
        }
    }
    
    var padding: Edge.Set {
        switch self {
            case .user: .leading
            case .option: .trailing
            default: .vertical
        }
    }
}
