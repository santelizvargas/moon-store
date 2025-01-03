//
//  ProductManager.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import Foundation

final class ProductManager {
    private let networkManager: NetworkManager = .init()
    
    // MARK: - Create product
    
    func createProduct(name: String,
                       description: String,
                       salePrice: Double,
                       purchasePrice: Double,
                       stock: Int,
                       category: String,
                       imageDataSet: [Data]) async throws {
        let parameters: [String: Any] = [
            "name": name,
            "description": description,
            "salePrice": salePrice,
            "purchasePrice": purchasePrice,
            "category": category,
            "stock": stock
        ]
        
        do {
            let data = try await networkManager.postMultipartData(for: .products,
                                                                  with: parameters,
                                                                  dataSet: imageDataSet)
            let response = try JSONDecoder().decode(CreateProductResponse.self, from: data)
            if response.code == 500 {
                throw MSError.duplicateKey
            }
        } catch {
            throw error
        }
    }
}
