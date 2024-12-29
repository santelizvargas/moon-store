//
//  MSPath.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/3/24.
//

import Foundation

enum MSEndpoint {
    case users
    case login
    case updatePassword
    case products
    case productCount
    case register
    case enableUser
    case disableUser
    case roles
    case usersChart
    case invoices
    case backupDatabase
    case restoreDatabase
    case listDatabase
    
    var path: String {
        "\(prefixV1)\(endpoint)"
    }
    
    var prefixV1: String { "/api/v1" }
    
    var endpoint: String {
        switch self {
            case .products: "/products"
            case .productCount: "/products/count"
            case .users: "/auth"
            case .login: "/auth/login"
            case .updatePassword: "/auth/password"
            case .register: "/auth/register"
            case .usersChart: "/auth/chart"
            case .enableUser: "/auth/enable"
            case .disableUser: "/auth/disable"
            case .roles: "/rbac/roles"
            case .invoices: "/invoices"
            case .backupDatabase: "/database/backup"
            case .restoreDatabase: "/database/restore"
            case .listDatabase: "/database/list"
        }
    }
}
