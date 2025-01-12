//
//  InvoiceManager.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/8/25.
//

import Foundation

final class InvoiceManager {
    private let networkManager: NetworkManager = NetworkManager()
    private let decoder: JSONDecoder = .init()
    
    func getInvoices() async throws -> [InvoiceModel] {
        do {
            let data = try await networkManager.getData(for: .invoices)
            let response = try decoder.decode(InvoiceModelResponse.self, from: data)
            return response.invoices
        } catch {
            throw error
        }
    }

    func createInvoice(invoice: InvoiceSaleModel) async throws {
        let parameters: [String: Any] = [
            "customerName": invoice.clientName,
            "customerIdentification": invoice.clientIdentification,
            "totalAmount": invoice.totalPrice,
            "products": invoice.products.map { $0.parameters }
        ]
        
        do {
            try await networkManager.postData(for: .invoices,
                                                 with: parameters)
        } catch {
            throw error
        }
    }
    
    func getInvoiceCount() async throws -> Int {
        do {
            let data = try await networkManager.getData(for: .invoicesCount)
            let response = try decoder.decode(InvoiceCountResponse.self, from: data)
            return response.count
        } catch {
            throw error
        }
    }
}
