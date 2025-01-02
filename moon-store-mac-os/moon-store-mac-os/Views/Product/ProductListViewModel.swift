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
    
    private let networkManager: NetworkManager = .init()
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
                let data = try await networkManager.getData(for: .products)
                let response = try decoder.decode(ProductResponse.self, from: data)
                products = response.data
                productList = products
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
