//
//  BaseNetworkService.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/3/24.
//

import Foundation

private enum Constants {
    static let scheme: String = "https"
    static let baseUrl: String = "moon-store-production.up.railway.app"
}

actor BaseNetworkService {
    
    private func request(request: URLRequest) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode,
                          let data {
                    continuation.resume(returning: data)
                }
            }.resume()
        }
    }
}
