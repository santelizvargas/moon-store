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
            throw NSError(domain: "Invalid url", code: 0)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        return try await request(urlRequest: urlRequest)
    }
    
    func postData(path: MSPath, parameters: [String: Any]) async throws -> Data {
        components.path = path.endpoint
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url else {
            throw NSError(domain: "Invalid url", code: 0)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let json = try? JSONSerialization.data(withJSONObject: parameters)
        urlRequest.httpBody = json
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return try await request(urlRequest: urlRequest)
    }
    
    func deleteData(path: MSPath, parameters: [String: Any]) async throws -> Data {
        components.path = path.endpoint
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url else {
            throw NSError(domain: "Invalid url", code: 0)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        return try await request(urlRequest: urlRequest)
    }
    
    func putData(path: MSPath, parameters: [String: Any]) async throws -> Data {
        components.path = path.endpoint
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url else {
            throw NSError(domain: "Invalid url", code: 0)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        return try await request(urlRequest: urlRequest)
    }
    
    func request(urlRequest: URLRequest) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return data
        } catch {
            throw error
        }
    }
}
