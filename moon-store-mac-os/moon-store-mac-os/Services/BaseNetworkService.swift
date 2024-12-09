//
//  BaseNetworkService.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/3/24.
//

import Foundation

// TODO: - Error handling

private enum Constants {
    static let scheme: String = "https"
    static let baseUrl: String = "moon-store-production.up.railway.app"
    static let GET: String = "GET"
    static let POST: String = "POST"
    static let DELETE: String = "DELETE"
    static let PUT: String = "PUT"
}

class BaseNetworkService {
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
    
    // MARK: - HTTP GET
    
    func getData(path: MSPath) async throws -> Data {
        components.path = path.endpoint
        
        guard let url = components.url else {
            throw NSError(domain: "Invalid url", code: 0)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.GET
        
        return try await request(urlRequest: urlRequest)
    }
    
    // MARK: - HTTP POST
    
    func postData(path: MSPath, parameters: [String: Any]) async throws -> Data {
        components.path = path.endpoint
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url else {
            throw NSError(domain: "Invalid url", code: 0)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.POST
        
        do {
            let json = try JSONSerialization.data(withJSONObject: parameters)
            urlRequest.httpBody = json
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return try await request(urlRequest: urlRequest)
        } catch {
            throw NSError(domain: "Error posting data: \(error.localizedDescription)", code: 500)
        }
        
        
    }
    
    // MARK: - HTTP POST Multipart
    
    func postMultipartData(path: MSPath,
                           parameters: [String: Any],
                           dataSet: [Data]) async throws -> Data {
        components.path = path.endpoint
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url else {
            throw NSError(domain: "Invalid url", code: 0)
        }
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.POST
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        for (key, value) in parameters {
            data.appendString("--\(boundary)\r\n")
            data.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            data.appendString("\(value)\r\n")
        }
        
        for value in dataSet {
            data.appendString("--\(boundary)\r\n")
            data.appendString("Content-Disposition: form-data; name=\"images\"; filename=\"image-\(boundary).jpg\"\r\n")
            data.appendString("Content-Type: image/jpeg\r\n\r\n")
            data.append(value)
            data.appendString("\r\n")
        }
        
        data.appendString("--\(boundary)--\r\n")
        
        urlRequest.httpBody = data
        
        return try await request(urlRequest: urlRequest)
    }
    
    // MARK: - HTTP DELETE
    
    func deleteData(path: MSPath, parameters: [String: Any]) async throws -> Data {
        components.path = path.endpoint
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url else {
            throw NSError(domain: "Invalid url", code: 0)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.DELETE
        
        return try await request(urlRequest: urlRequest)
    }
    
    // MARK: - HTTP UPDATE
    
    func putData(path: MSPath, parameters: [String: Any]) async throws -> Data {
        components.path = path.endpoint
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url else {
            throw NSError(domain: "Invalid url", code: 0)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.PUT
        
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
