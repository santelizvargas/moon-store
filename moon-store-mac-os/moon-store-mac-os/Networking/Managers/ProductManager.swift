//
//  ProductManager.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import Foundation

private enum Constants {
    static let errorCode: Int = 500
}

final class ProductManager {
    private let networkManager: NetworkManager = .init()
    private let decoder: JSONDecoder = .init()
    
    // MARK: - Create product
    
    func addProduct(name: String,
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
            let response = try decoder.decode(CreateProductResponse.self, from: data)
            if response.code == Constants.errorCode {
                throw MSError.duplicateKey
            }
        } catch {
            throw error
        }
    }
    
    // MARK: - Delete Product
    
    func deleteProduct(with id: Int) async throws {
        let parameters: [String: Any] = [
            "id": id
        ]
        
        do {
            let data = try await networkManager.deleteData(for: .products, with: parameters)
            let response = try decoder.decode(DeleteProductResponse.self, from: data)
            
            if response.code == Constants.errorCode {
                throw MSError.notFound
            }
        } catch {
            throw error
        }
    }
    
    // MARK: Get Products
    
    func getProducts() async throws -> [ProductModel] {
        do {
            let data = try await networkManager.getData(for: .products)
            let response = try decoder.decode(ProductResponse.self, from: data)
            return response.data
        } catch {
            throw error
        }
    }
    
    // MARK: Supply product
    
    func supplyProduct(id: Int,
                       with quantity: Double) async throws {
        let parameters: [String: Any] = [
            "id": id,
            "stock": quantity
        ]
        
        do {
            let data = try await networkManager.putData(for: .products, with: parameters)
            let response = try JSONDecoder().decode(CreateProductResponse.self, from: data)
            
            if response.code == 500 {
                throw MSError.notFound
            }
        } catch {
            throw error
        }
    }
}
