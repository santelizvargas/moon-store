//
//  ProductCountResponse.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/4/25.
//

struct ProductCountResponse: Decodable {
    let message: String
    let productCount: ProductCount
    
    enum CodingKeys: String, CodingKey {
        case message
        case productCount = "data"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.productCount = try container.decode(ProductCount.self, forKey: .productCount)
    }
}
