//
//  CreateProductResponse.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/2/25.
//

struct CreateProductResponse: Decodable {
    let message: String
    let code: Int
    let data: ProductModel?
}
