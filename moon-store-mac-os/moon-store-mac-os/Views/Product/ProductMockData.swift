//
//  ProductMockData.swift
//  moon-store-mac-os
//
//  Created by Diana Zeledon on 13/12/24.
//

import Foundation

struct ProductoMockData: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let inStock: Int
    let price: String

}

extension ProductoMockData {
    static let mockProductos: [ProductoMockData] = [
        ProductoMockData(name: "Manzanas", category: "Frutas", inStock: 25, price: "$1.20"),
        ProductoMockData(name: "Leche", category: "Lácteos", inStock: 15, price: "$0.99"),
        ProductoMockData(name: "Pan Integral", category: "Panadería", inStock: 30, price: "$2.50"),
        ProductoMockData(name: "Yogur Natural", category: "Lácteos", inStock: 10, price: "$1.80"),
        ProductoMockData(name: "Zanahorias", category: "Verduras", inStock: 40, price: "$0.70"),
        ProductoMockData(name: "Huevos", category: "Lácteos", inStock: 60, price: "$3.20"),
        ProductoMockData(name: "Queso Cheddar", category: "Lácteos", inStock: 20, price: "$4.50")
    ]
}
