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
}
