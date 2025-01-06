//
//  Screen.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 17/11/24.
//

enum ScreenSection: String, Identifiable, CaseIterable {
    case overview = "Vista General"
    case inventory = "Inventario"
    case billing = "Facturación"
    
    var id: String { rawValue }
    
    var screens: [Screen] {
        switch self {
            case .overview: [.charts, .users]
            case .inventory: [.products, .backups]
            case .billing: [.newSale, .salesReport]
        }
    }
    
    static func allCases(for roleId: Int) -> [ScreenSection] {
        guard let role = Role(rawValue: roleId) else { return [] }
        
        return switch role {
            case .owner, .admin: ScreenSection.allCases
            case .seller: [.billing]
            case .supplier: [.inventory]
        }
    }
}

enum Screen: String, Identifiable {
    case charts = "Gráficas"
    case users = "Usuarios"
    case products = "Lista de Productos"
    case newSale = "Nueva Venta"
    case salesReport = "Reporte de Ventas"
    case profile = "Perfil"
    case backups = "Backups"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
            case .charts: "square.grid.2x2"
            case .users, .profile: "person"
            case .products: "list.bullet.clipboard"
            case .newSale: "plus.circle"
            case .salesReport: "chart.line.uptrend.xyaxis"
            case .backups: "externaldrive.badge.icloud"
        }
    }
}

// TODO: - Use this enum for Roles instead of Role Model, move to a file

enum Role: Int {
    case owner, admin, seller, supplier
}
