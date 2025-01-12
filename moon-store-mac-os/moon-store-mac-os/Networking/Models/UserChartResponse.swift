//
//  UserChartResponse.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 1/12/25.
//

import Foundation

struct UserChartResponse: Decodable {
    let activeUsersCount: Int
    let suspendedUsersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case activeUsersCount = "usersCount"
        case suspendedUsersCount = "suspendedCount"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        activeUsersCount = try container.decode(Int.self, forKey: .activeUsersCount)
        suspendedUsersCount = try container.decode(Int.self, forKey: .suspendedUsersCount)
    }
}
