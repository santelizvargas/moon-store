//
//  ProductMockData.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 13/12/24.
//

import Foundation
import SwiftUI

struct ProductoMockData: Identifiable {
    let id = UUID()
    let name: String
    let category: CategoryType
    let inStock: Int
    let price: String

}

enum CategoryType: String, CaseIterable {
    case frutas = "Frutas"
    case lacteos = "Lácteos"
    case panaderia = "Panadería"
    case verduras = "Verduras"
    case otros = "Otros"
    
    // Color asociado a cada categoría
    var color: Color {
        switch self {
        case .frutas: return .green
        case .lacteos: return .blue
        case .panaderia: return .orange
        case .verduras: return .red
        case .otros: return .gray
        }
    }
}

extension ProductoMockData {
    static let mockProductos: [ProductoMockData] = [
        ProductoMockData(name: "Manzanas", category: .frutas, inStock: 25, price: "$1.20"),
        ProductoMockData(name: "Leche", category: .lacteos, inStock: 15, price: "$0.99"),
        ProductoMockData(name: "Pan Integral", category: .panaderia, inStock: 30, price: "$2.50"),
        ProductoMockData(name: "Yogur Natural", category: .lacteos, inStock: 10, price: "$1.80"),
        ProductoMockData(name: "Zanahorias", category: .verduras, inStock: 40, price: "$0.70"),
        ProductoMockData(name: "Huevos", category: .lacteos, inStock: 60, price: "$3.20"),
        ProductoMockData(name: "Queso Cheddar", category: .lacteos, inStock: 20, price: "$4.50")
    ]
}
