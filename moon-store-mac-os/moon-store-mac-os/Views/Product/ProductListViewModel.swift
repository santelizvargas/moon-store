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
        AlertPresenter.showConfirmationAlert(message: "¿Está seguro que quiere eliminar el producto?",
                                             actionButtonTitle: "Eliminar") { [weak self] in
            guard let self else { return }
            self.deleteProduct(with: id)
        }
    }
    
    func supplyProduct(with id: Int, quantity: Int) {
        isLoading = true
        
        Task { @MainActor in
            do {
                try await productManager.supplyProduct(id: id, with: quantity)
                getProducts()
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
    
    private func deleteProduct(with id: Int) {
        isLoading = true
        Task { @MainActor in
            defer {
                isLoading = false
            }
            
            do {
                try await productManager.deleteProduct(with: id)
                getProducts()
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
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
