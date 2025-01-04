//
//  CreateProductResponse.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

struct CreateProductResponse: Decodable {
    let message: String
    let code: Int
    let product: ProductModel?
    
    enum CodingKeys: String, CodingKey {
        case message
        case code
        case product = "data"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.code = try container.decode(Int.self, forKey: .code)
        self.product = try container.decodeIfPresent(ProductModel.self, forKey: .product)
    }
}
