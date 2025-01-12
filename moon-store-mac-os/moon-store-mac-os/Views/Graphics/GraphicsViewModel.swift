//
//  GraphicsViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/12/25.
//

import Foundation

final class GraphicsViewModel: ObservableObject {
    @Published var cardGraphicModels: [CardGraphicModel] = []
    @Published var isLoading: Bool = false
    
    private var productsCount: Int = 0
    private var invoicesCount: Int = 0
    private var activeUsersCount: Int = 0
    private var suspendedUsersCount: Int = 0
    
    private let productManager: ProductManager = .init()
    private let invoiceManager: InvoiceManager = .init()
    private let userManager: UserManager = .init()
    
    init() {
        getCardGraphicCounters()
    }
    
    private func getCardGraphicCounters() {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                productsCount = try await productManager.getProductCount()
                invoicesCount = try await invoiceManager.getInvoiceCount()
                
                let userCharts = try await userManager.getUsersChart()
                
                activeUsersCount = userCharts.activeUsersCount
                suspendedUsersCount = userCharts.suspendedUsersCount
                
                loadCardGraphicCounters()
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }
    
    private func loadCardGraphicCounters() {
        cardGraphicModels = [
            CardGraphic.products(productsCount).model,
            CardGraphic.invoices(invoicesCount).model,
            CardGraphic.activeUsers(activeUsersCount).model,
            CardGraphic.suspendedUsers(suspendedUsersCount).model,
        ]
    }
}
