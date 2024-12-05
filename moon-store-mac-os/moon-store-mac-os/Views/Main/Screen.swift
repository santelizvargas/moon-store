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
            case .inventory: [.products]
            case .billing: [.newSale, .salesReport]
        }
    }
}

enum Screen: String, Identifiable {
    case charts = "Gráficas"
    case users = "Usuarios"
    case products = "Lista de Productos"
    case newSale = "Nueva Venta"
    case salesReport = "Reporte de Ventas"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
            case .charts: "square.grid.2x2"
            case .users: "person"
            case .products: "list.bullet.clipboard"
            case .newSale: "plus.circle"
            case .salesReport: "chart.line.uptrend.xyaxis"
        }
    }
}
