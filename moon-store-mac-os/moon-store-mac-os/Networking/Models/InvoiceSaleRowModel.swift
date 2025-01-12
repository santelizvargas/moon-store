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
    var description: String = ""
    var quantity: String = "1"
    var price: String = "0"
    
    var selectedProduct: ProductModel? = nil {
        didSet {
            id = selectedProduct?.id.description ?? ""
            name = selectedProduct?.name ?? ""
            price = selectedProduct?.salePrice.description ?? ""
        }
    }
    
    var totalPrice: String {
        let quantity = Double(quantity) ?? .zero
        let price = Double(price) ?? .zero
        
        return "\(quantity * price)"
    }
    
    var parameters: [String: Any] {
        [
            "id": selectedProduct?.id ?? .zero,
            "name": name,
            "description": description,
            "quantity": Int(quantity) ?? .zero,
            "price": selectedProduct?.salePrice ?? .zero
        ]
    }
}
