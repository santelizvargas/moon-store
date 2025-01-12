//
//  Information.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 6/1/25.
//

import SwiftUI

struct CardGraphicModel: Identifiable {
    let id: UUID = .init()
    let title: String
    let count: Int
    let iconName: String
    let description: String
    let color: Color
}

enum CardGraphic {
    case products(Int)
    case invoices(Int)
    case users(Int)
    
    var title: String {
        switch self {
            case .products: return "Productos"
            case .invoices: return "Facturas"
            case .users: return "Usuarios"
        }
    }
    
    var iconName: String {
        switch self {
            case .products: return "cart.fill"
            case .invoices: return "doc.text.fill"
            case .users: return "person.2.fill"
        }
    }
    
    var description: String {
        switch self {
            case .products: return "Productos actualmente registrados en el inventario."
            case .invoices: return "Facturas generadas y almacenadas en el sistema."
            case .users: return "Usuarios activos registrados en la plataforma."
        }
    }
    
    var color: Color {
        switch self {
            case .products: return .msPrimary
            case .invoices: return .msGreen
            case .users: return .msOrange
        }
    }
    
    var model: CardGraphicModel {
        
        var count: Int {
            switch self {
                case .products(let count): count
                case .invoices(let count): count
                case .users(let count): count
            }
        }
        
        return CardGraphicModel(
            title: title,
            count: count,
            iconName: iconName,
            description: description,
            color: color
        )
    }
}

// MARK: - Mock Data

extension CardGraphicModel {
    static let mockInfo = [
        CardGraphicModel(
            title: "Productos",
            count: 203,
            iconName: "cart.fill",
            description: "Productos actualmente registrados en el inventario.",
            color: .msPrimary
        ),
        CardGraphicModel(
            title: "Facturas",
            count: 1250,
            iconName: "doc.text.fill",
            description: "Facturas generadas y almacenadas en el sistema.",
            color: .msGreen
        ),
        CardGraphicModel(
            title: "Usuarios",
            count: 87,
            iconName: "person.2.fill",
            description: "Usuarios activos registrados en la plataforma.",
            color: .msOrange
        )
    ]
}
