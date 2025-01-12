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
    case activeUsers(Int)
    case suspendedUsers(Int)
    
    private var title: String {
        switch self {
            case .products: "Productos"
            case .invoices: "Facturas"
            case .activeUsers: "Usuarios activos"
            case .suspendedUsers: "Usuarios suspendidos"
        }
    }
    
    private var iconName: String {
        switch self {
            case .products: "cart.fill"
            case .invoices: "doc.text.fill"
            case .activeUsers: "person.2.fill"
            case .suspendedUsers: "person.fill.xmark"
        }
    }
    
    private var description: String {
        switch self {
            case .products: "Productos actualmente registrados en el inventario."
            case .invoices: "Facturas generadas y almacenadas en el sistema."
            case .activeUsers: "Usuarios activos registrados en la plataforma."
            case .suspendedUsers: "Usuarios suspendidos registrados en la plataforma."
        }
    }
    
    private var color: Color {
        switch self {
            case .products: .msPrimary
            case .invoices: .msGreen
            case .activeUsers: .msDarkBlue
            case .suspendedUsers: .msOrange
        }
    }
    
    private var count: Int {
        switch self {
            case .products(let count): count
            case .invoices(let count): count
            case .activeUsers(let count): count
            case .suspendedUsers(let count): count
        }
    }
    
    var model: CardGraphicModel {
        CardGraphicModel(
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
        CardGraphic.products(300).model,
        CardGraphic.invoices(400).model,
        CardGraphic.activeUsers(300).model,
    ]
}
