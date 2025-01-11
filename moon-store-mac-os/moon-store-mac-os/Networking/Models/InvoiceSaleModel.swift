//
//  InvoiceSaleModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/8/25.
//

import Foundation

private enum Constants {
    static let IVAPercentage: Double = 0.15
    static let invalidDateText: String = "Fecha inválida"
}

struct InvoiceSaleModel {
    var id: Int = 0
    var clientName: String = ""
    var clientIdentification: String = ""
    var createAt: String = "\(Date.now)".formattedDate ?? Constants.invalidDateText
    var products: [InvoiceSaleRowModel] = [.init()]
}

extension InvoiceSaleModel {
    var subtotalPrice: Double {
        products.reduce(.zero) { result, product in
            let price = Double(product.totalPrice) ?? .zero
            return result + price
        }
    }
    
    var totalIva: Double { subtotalPrice * Constants.IVAPercentage }
    var totalPrice: Double { subtotalPrice + totalIva }
}
