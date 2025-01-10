//
//  Information.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 6/1/25.
//

import SwiftUI

struct Information: Identifiable {
    let id: UUID = UUID()
    let title: String
    let count: Int
    let iconName: String
    let description: String
    let color: Color
}

// MARK: - Mock Data

extension Information {
    static let mockInfo = [
        Information(
            title: "Productos",
            count: 203,
            iconName: "cart.fill",
            description: "Productos actualmente registrados en el inventario.",
            color: .msPrimary
        ),
        Information(
            title: "Facturas",
            count: 1250,
            iconName: "doc.text.fill",
            description: "Facturas generadas y almacenadas en el sistema.",
            color: .msGreen
        ),
        Information(
            title: "Usuarios",
            count: 87,
            iconName: "person.2.fill",
            description: "Usuarios activos registrados en la plataforma.",
            color: .msOrange
        )
    ]
}
