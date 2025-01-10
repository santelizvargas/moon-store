//
//  InvoiceDetailModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/8/25.
//

struct DetailsInvoiceModel: Decodable {
    let id: Int
    let productName: String
    let productQuantity: Int
    let productPrice: Double
    let productCategory: String?
    let invoiceId: Int
    let createdAt: String
}
