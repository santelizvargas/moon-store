//
//  LoginResponse.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/17/24.
//

import Foundation

struct LoginResponseModel: Decodable {
    let accessToken: String
    let expiresIn: Int
    let data: UserModel
}
