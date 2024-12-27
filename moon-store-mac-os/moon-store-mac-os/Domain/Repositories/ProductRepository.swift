//
//  ProductRepository.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/23/24.
//

import Foundation

final class ProductRepository: BaseNetworkService {
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = .init()) {
        self.decoder = decoder
    }
    
    func getProducts() async throws -> [ProductModel] {
        do {
            let result = try await getData(for: MSEndpoint.products.path)
            let productResponse = try decoder.decode(ProductResponse.self, from: result)
            
            if productResponse.data.isEmpty { throw MSError.noData }
            
            return productResponse.data
        } catch let error as MSError {
            throw error
        }
    }
}
