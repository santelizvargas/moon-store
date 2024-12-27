//
//  ProductListViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/24/24.
//

import Foundation

final class ProductListViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var isLoading: Bool = false
    
    private let productRepository: ProductRepository
    
    init(productRepository: ProductRepository = .init()) {
        self.productRepository = productRepository
        getProducts()
    }
    
    func getProducts() {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                products = try await productRepository.getProducts()
            } catch let error as MSError {
                AlertPresenter().showAlert(type: .error,
                                           alertMessage: error.friendlyMessage)
            }
        }
    }
}
