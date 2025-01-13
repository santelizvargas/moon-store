//
//  GraphicsViewModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/12/25.
//

import Foundation

private enum Constants {
    static let oneToPlus: Int = 1
    static let weekdays: [String] = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"]
    static let zero: Int = .zero
}

private typealias AsyncData = ([ProductModel], [InvoiceModel], UserChartResponse)

final class GraphicsViewModel: ObservableObject {
    @Published var cardGraphicModels: [CardGraphicModel] = []
    @Published var mostProductsSold: [ChartData] = []
    @Published var invoicesByWeekday: [ChartData] = []
    @Published var mostCategoriesSold: [ChartData] = []
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
                let asyncData = try await fetchAsyncData()
                processFetchedData(asyncData)
            } catch {
                AlertPresenter.showAlert(with: error)
            }
        }
    }

    private func fetchAsyncData() async throws -> AsyncData {
        async let products = productManager.getProducts()
        async let invoices = invoiceManager.getInvoices()
        async let users = userManager.getUsersChart()
        return try await (products, invoices, users)
    }

    private func processFetchedData(_ data: AsyncData) {
        let (products, invoices, userChart) = data
        updateProductData(with: products)
        updateInvoiceData(with: invoices)
        activeUsersCount = userChart.activeUsersCount
        loadStaticData()
    }

    private func updateProductData(with products: [ProductModel]) {
        self.products = products
        productsCount = products.count
    }

    private func updateInvoiceData(with invoices: [InvoiceModel]) {
        self.invoices = invoices
        invoicesCount = invoices.count
    }
    
    private func loadStaticData() {
        loadCardGraphicCounters()
        loadMostProductsSold()
        loadInvoicesByWeekday()
        loadMostCategoriesSold()
    }
    
    private func loadCardGraphicCounters() {
        cardGraphicModels = [
            CardGraphic.products(productsCount).model,
            CardGraphic.invoices(invoicesCount).model,
            CardGraphic.users(activeUsersCount).model
        ]
    }
    
    private func loadMostProductsSold() {
        let productSalesCount = invoices
            .flatMap { $0.products }
            .reduce(into: [Int: Int]()) { result, product in
                result[product.id, default: .zero] += Constants.oneToPlus
            }
        
        mostProductsSold = products
            .compactMap { product in
                guard let salesCount = productSalesCount[product.id], salesCount > .zero else { return nil }
                return ChartData(name: product.name, value: Double(salesCount))
            }
            .sorted(by: { $0.value < $1.value })
    }
    
    private func loadInvoicesByWeekday() {
        var weeklyInvoices = Dictionary(
            uniqueKeysWithValues: Constants.weekdays.map {
                ($0, Constants.zero)
            }
        )
        
        for invoice in invoices {
            guard let weekday = invoice.createdAt.weekday else { continue }
            
            weeklyInvoices[weekday, default: Constants.zero] += Constants.oneToPlus
        }
        
        let invoicesByWeekday: [ChartData] = Constants.weekdays.map { day in
            let invoiceCount = weeklyInvoices[day, default: Constants.zero]
            return ChartData(name: day, value: Double(invoiceCount))
        }
        
        self.invoicesByWeekday = invoicesByWeekday
    }
    
    private func loadMostCategoriesSold() {
        var categorySalesCount: [String: Int] = [:]
        
        for invoice in invoices {
            for product in invoice.products {
                let category = product.category.title
                categorySalesCount[category, default: Constants.zero] += Constants.oneToPlus
            }
        }
        
        var mostCategoriesSold: [ChartData] = []
        
        for (category, salesCount) in categorySalesCount {
            let chartData = ChartData(name: category, value: Double(salesCount))
            mostCategoriesSold.append(chartData)
        }
        
        mostCategoriesSold.sort { $0.value > $1.value }
        
        self.mostCategoriesSold = mostCategoriesSold
    }
}
