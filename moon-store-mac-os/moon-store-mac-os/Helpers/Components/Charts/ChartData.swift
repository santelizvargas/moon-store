//
//  ChartData.swift
//  moon-store-mac-os
//
//  Created by Steven Santeliz on 10/1/25.
//

import Foundation

struct ChartData: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let value: Double
}

// MARK: - Data Mock

extension ChartData {
    static let topSellingProducts: [ChartData] = [
        ChartData(name: "iPhone 15", value: 500),
        ChartData(name: "MacBook Pro", value: 450),
        ChartData(name: "iPad Air", value: 300),
        ChartData(name: "Apple Watch", value: 350),
        ChartData(name: "AirPods Pro", value: 400),
        ChartData(name: "Magic Keyboard", value: 200),
        ChartData(name: "Apple Pencil", value: 180),
        ChartData(name: "HomePod Mini", value: 220),
        ChartData(name: "Apple TV", value: 150),
        ChartData(name: "MagSafe Charger", value: 100)
    ]

    
    static let products: [ChartData] = [
        ChartData(name: "Lunes", value: 200),
        ChartData(name: "Martes", value: 250),
        ChartData(name: "Miercoles", value: 100),
        ChartData(name: "Jueves", value: 300),
        ChartData(name: "Viernes", value: 280)
    ]
    
    static let invoices: [ChartData] = [
        ChartData(name: "Lunes", value: 23),
        ChartData(name: "Martes", value: 25),
        ChartData(name: "Miercoles", value: 10),
        ChartData(name: "Jueves", value: 20),
        ChartData(name: "Viernes", value: 24)
    ]
}
