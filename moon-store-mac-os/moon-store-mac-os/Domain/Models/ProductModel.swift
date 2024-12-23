//
//  ProductModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/23/24.
//

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
}

struct ProductModel: Decodable {
    let id: Int
    let name: String
    let description: String
    let stock: Int
    let salePrice: Double
    let purchasePrice: Double
    let category: ProductCategory
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}
