//
//  HTTPMethod.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/3/24.
//

import Foundation

enum HttpMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
}

enum MSPath {
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
    
    var endpoint: String {
        var path: String {
            switch self {
                case .products: "products"
                case .productCount: "products/count"
                case .users: "auth"
                case .login: "auth/login"
                case .updatePassword: "auth/password"
                case .register: "auth/register"
                case .usersChart: "auth/chart"
                case .enableUser: "auth/enable"
                case .disableUser: "auth/disable"
                case .roles: "rbac/roles"
                case .invoices: "invoices"
                case .backupDatabase: "database/backup"
                case .restoreDatabase: "database/restore"
                case .listDatabase: "database/list"
            }
        }
        return "\(apiPrefix)\(path)/"
    }
    
    private var apiPrefix: String { "/api/v1/" }
}
