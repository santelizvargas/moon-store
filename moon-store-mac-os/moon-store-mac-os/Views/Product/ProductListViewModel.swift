//
//  ProductListViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/24/24.
//

import Foundation

final class ProductListViewModel: ObservableObject {
    @Published var productList: [ProductModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = "" {
        didSet {
            filterProducts()
        }
    }
    
    var shouldShowEmptyView: Bool {
        productList.isEmpty &&
        !isLoading &&
        !isSearchInProgress
    }
    
    private let productManager: ProductManager = .init()
    private let decoder: JSONDecoder = .init()
    
    private var isSearchInProgress: Bool = false
    private var products: [ProductModel] = []
    private var productsFiltered: [ProductModel] = []
    
    init () {
        getProducts()
    }
    
    func getProducts() {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                products = try await productManager.getProducts()
                productList = products
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
    
    func showDeleteAlert(with id: Int) {
        let deleteAction: () -> Void = { [weak self] in
            
            guard let self else { return }
            
            self.isLoading = true
            
            Task { @MainActor in
                defer {
                    self.isLoading = false
                }
                
                do {
                    try await self.productManager.deleteProduct(with: id)
                    self.getProducts()
                } catch {
                    AlertPresenter.showAlert(with: error)
                }
            }
        }

        AlertPresenter.showConfirmationAlert(message: "¿Está seguro que quiere eliminar el producto?",
                                             actionButtonTitle: "Eliminar",
                                             action: deleteAction)
    }
    
    private func filterProducts() {
        isSearchInProgress = searchText != ""
        productsFiltered = products.filter { product in
            product.name.localizedCaseInsensitiveContains(searchText)
        }
        
        productList = isSearchInProgress
        ? productsFiltered
        : products
    }
}
