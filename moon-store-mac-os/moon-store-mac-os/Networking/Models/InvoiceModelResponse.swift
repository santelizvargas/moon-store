//
//  InvoiceModelResponse.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/8/25.
//

struct InvoiceModelResponse: Decodable {
    let invoices: [InvoiceModel]
    
    enum CodingKeys: String, CodingKey {
        case invoices = "data"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        invoices = try container.decode([InvoiceModel].self, forKey: .invoices)
    }
}
