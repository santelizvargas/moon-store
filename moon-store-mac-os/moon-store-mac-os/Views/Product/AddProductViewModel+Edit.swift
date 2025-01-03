//
//  AddProductViewModel+Edit.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

import SwiftUI
import _PhotosUI_SwiftUI

@MainActor
final class AddProductViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var name: String = ""
    @Published var price: String = ""
    @Published var stock: String = ""
    @Published var description: String = ""
    @Published var category: ProductCategory = .laptop
    
    var canCreateProduct: Bool {
        name.isEmpty ||
        price.isEmpty ||
        description.isEmpty ||
        stock.isEmpty
    }
    
    private let productManager: ProductManager = .init()
    
    func createProduct() {
        guard canCreateProduct,
              let price = Double(price),
              let stock = Int(stock) else { return }
        
        isLoading = true
        
        Task { @MainActor in
            
            defer {
                isLoading = false
            }
            
            do {
                try await productManager.createProduct(name: name,
                                                       description: description,
                                                       salePrice: price,
                                                       purchasePrice: price,
                                                       stock: stock,
                                                       category: category.id,
                                                       imageDataSet: [])
                AlertPresenter.showAlert("Producto creado exitosamente!", type: .info)
                resetProductProperties()
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
    
    private func resetProductProperties() {
        name = ""
        price = ""
        stock = ""
        description = ""
    }
    
}
