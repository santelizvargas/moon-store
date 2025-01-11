//
//  CreateInvoiceViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/11/25.
//

import Foundation

final class CreateInvoiceViewModel: ObservableObject {
    @Published var invoice: InvoiceSaleModel = .init()
    @Published var products: [ProductModel] = []
    @Published var isLoading: Bool = false
    
    private let invoiceManager: InvoiceManager = .init()
    private let productManager: ProductManager = .init()
    
    init() {
        getProducts()
    }
    
    func addInvoiceRow() {
        invoice.products.append(.init())
    }
    
    func removeInvoiceRow(at index: Int) {
        invoice.products.remove(at: index)
    }
    
    func createInvoice() {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                try await invoiceManager.createInvoice(invoice: invoice)
                resetPropertiesToDefaultValue()
                getProducts()
                AlertPresenter.showAlert("Factura creada correctamente!")
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
    
    private func getProducts() {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                products = try await productManager.getProducts()
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
    
    private func resetPropertiesToDefaultValue() {
        invoice = .init()
        products = []
    }
}
