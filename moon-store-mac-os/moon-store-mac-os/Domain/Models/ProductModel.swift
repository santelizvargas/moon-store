//
//  ProductModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/23/24.
//

import SwiftUI

enum ProductCategory: String, Decodable {
    case laptop
    case phone
    case audio
    case pc
    case printer
    case battery
    case wearable
    case home
    case peripheral
    case networking
    
    var title: String { rawValue.capitalized }
    
    var color: Color {
        switch self {
            case .laptop, .phone, .pc: .msPrimary
            case .audio, .printer, .battery: .msOrange
            case .wearable, .home, .peripheral, .networking: .msGreen
        }
    }
}

struct ProductModel: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let stock: Int
    let salePrice: Double
    let purchasePrice: Double
    let category: ProductCategory
    let images: [String]
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}
