//
//  GraphicsViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/12/25.
//

import Foundation

private enum Constants {
    static let oneToPlus: Int = 1
    static let weekdayOrder: [String] = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"]
    static let zero: Int = .zero
}

final class GraphicsViewModel: ObservableObject {
    @Published var cardGraphicModels: [CardGraphicModel] = []
    @Published var mostProductsSold: [ChartData] = []
    @Published var productsSoldByWeekday: [ChartData] = []
    @Published var isLoading: Bool = false
    
    private var productsCount: Int = Constants.zero
    private var invoicesCount: Int = Constants.zero
    private var activeUsersCount: Int = Constants.zero
    private var suspendedUsersCount: Int = Constants.zero
    private var products: [ProductModel] = []
    private var invoices: [InvoiceModel] = []
    
    private let productManager: ProductManager = .init()
    private let invoiceManager: InvoiceManager = .init()
    private let userManager: UserManager = .init()
    
    init() {
        loadData()
    }
    
    private func loadData() {
        isLoading = true
        
        Task { @MainActor in
            defer { isLoading = false }
            
            do {
                productsCount = try await productManager.getProductCount()
                invoicesCount = try await invoiceManager.getInvoiceCount()
                products = try await productManager.getProducts()
                invoices = try await invoiceManager.getInvoices()
                
                let userCharts = try await userManager.getUsersChart()
                
                activeUsersCount = userCharts.activeUsersCount
                suspendedUsersCount = userCharts.suspendedUsersCount
                
                loadCardGraphicCounters()
                loadMostProductsSold()
                loadProductsSoldByWeekday()
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
    
    private func loadMostProductsSold() {
        var productSalesCount: [Int: Int] = [:]

        for invoice in invoices {
            for product in invoice.products {
                productSalesCount[product.id, default: Constants.zero] += Constants.oneToPlus
            }
        }

        var mostProductSold: [ChartData] = []
        
        for product in products {
            let salesCount = productSalesCount[product.id, default: Constants.zero]
            let chartData = ChartData(name: product.name, value: Double(salesCount))
            mostProductSold.append(chartData)
        }

        mostProductSold.sort { $0.value > $1.value }
        
        self.mostProductsSold = mostProductSold
    }
    
    private func loadProductsSoldByWeekday() {
        var weeklySales = Dictionary(
            uniqueKeysWithValues: Constants.weekdayOrder.map {
                ($0, Constants.zero)
            }
        )
        
        for invoice in invoices {
            guard let weekday = invoice.createdAt.weekday
            else { continue }
            
            weeklySales[weekday, default: Constants.zero] += Constants.oneToPlus
        }
        
        let productsSoldByWeekday: [ChartData] = Constants.weekdayOrder.compactMap { day in
            guard let sales = weeklySales[day] else { return nil }
            return ChartData(name: day, value: Double(sales))
        }
        
        self.productsSoldByWeekday = productsSoldByWeekday
    }
}
