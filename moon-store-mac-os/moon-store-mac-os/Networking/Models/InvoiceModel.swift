//
//  InvoiceModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/8/25.
//

struct InvoiceModel: Decodable, Identifiable {
    let id: Int
    let customerName: String
    let customerIdentification: String
    let totalAmount: Double
    let createdAt: String
    let products: [ProductModel]
    let details: [DetailsInvoiceModel]
}

