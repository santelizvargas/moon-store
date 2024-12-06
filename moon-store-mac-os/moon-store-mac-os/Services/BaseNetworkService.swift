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
    private var components: URLComponents = {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseUrl
        return components
    }()
    
    private func makeQueryItems(parameters: [String: Any]) -> [URLQueryItem] {
        parameters.map { key, value in
            URLQueryItem(name: key, value: value as? String)
        }
    }
    
    func getData(path: MSPath) async throws -> Data {
        components.path = path.endpoint
        
        guard let url = components.url else {
            throw NSError(domain: "Invalid request", code: 0)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethod.GET.rawValue
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return data
        } catch {
            throw error
        }
    }
}
