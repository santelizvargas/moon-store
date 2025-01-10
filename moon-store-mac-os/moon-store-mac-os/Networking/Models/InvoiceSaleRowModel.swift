//
//  InvoiceSaleRowModel.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/8/25.
//

import Foundation

struct InvoiceSaleRowModel: Hashable, Identifiable {
    var idString: String = UUID().uuidString
    var id: String = ""
    var name: String = ""
    var quantity: String = "1"
    var price: Double = 0
    var totalPrice: Double = 0
    
    var parameters: [String: Any] {
        [
            "id": Int(id) ?? 0,
            "name": name,
            "quantity": Int(quantity) ?? 0,
            "price": price
        ]
    }
}
