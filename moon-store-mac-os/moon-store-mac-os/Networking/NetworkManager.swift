//
//  NetworkManager.swift
//  moon-store-mac-os
//
//  Created by Jose Luna on 12/3/24.
//

import Foundation

private enum Constants {
    static let scheme: String = "https"
    static let baseUrl: String = "moon-store-production.up.railway.app"
    static let getHttpMethod: String = "GET"
    static let postHttpMethod: String = "POST"
    static let deleteHttpMethod: String = "DELETE"
    static let putHttpMethod: String = "PUT"
}

final class NetworkManager {
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
    
    func getData(for endpoint: MSEndpoint) async throws -> Data {
        components.path = endpoint.path
        
        guard let url = components.url else {
            throw MSError.badURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.getHttpMethod
        
        return try await request(urlRequest: urlRequest)
    }
    
    // MARK: - HTTP POST
    
    func postData(for endpoint: MSEndpoint,
                  with parameters: [String: Any]) async throws -> Data {
        components.path = endpoint.path
        
        guard let url = components.url else {
            throw MSError.badURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.postHttpMethod
        
        do {
            let json = try JSONSerialization.data(withJSONObject: parameters)
            urlRequest.httpBody = json
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return try await request(urlRequest: urlRequest)
        } catch {
            throw MSError.encodingError
        }
    }
    
    // MARK: - HTTP POST Multipart
    
    func postMultipartData(for endpoint: MSEndpoint,
                           with parameters: [String: Any],
                           dataSet: [Data]) async throws -> Data {
        components.path = endpoint.path
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url else {
            throw MSError.badURL
        }
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.postHttpMethod
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        for (key, value) in parameters {
            data.appendStringIfNeeded("--\(boundary)\r\n")
            data.appendStringIfNeeded("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            data.appendStringIfNeeded("\(value)\r\n")
        }
        
        for value in dataSet {
            data.appendStringIfNeeded("--\(boundary)\r\n")
            data.appendStringIfNeeded("Content-Disposition: form-data; name=\"images\"; filename=\"image-\(boundary).jpg\"\r\n")
            data.appendStringIfNeeded("Content-Type: image/jpeg\r\n\r\n")
            data.append(value)
            data.appendStringIfNeeded("\r\n")
        }
        
        data.appendStringIfNeeded("--\(boundary)--\r\n")
        
        urlRequest.httpBody = data
        
        return try await request(urlRequest: urlRequest)
    }
    
    // MARK: - HTTP DELETE
    
    func deleteData(for endpoint: MSEndpoint,
                    with parameters: [String: Any]) async throws -> Data {
        components.path = endpoint.path
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url else {
            throw MSError.badURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.deleteHttpMethod
        
        do {
            let json = try JSONSerialization.data(withJSONObject: parameters)
            urlRequest.httpBody = json
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return try await request(urlRequest: urlRequest)
        } catch {
            throw MSError.encodingError
        }
    }
    
    // MARK: - HTTP UPDATE
    
    func putData(for endpoint: MSEndpoint,
                 with parameters: [String: Any]) async throws -> Data {
        components.path = endpoint.path
        components.queryItems = makeQueryItems(parameters: parameters)
        
        guard let url = components.url else {
            throw MSError.badURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Constants.putHttpMethod
        
        do {
            let json = try JSONSerialization.data(withJSONObject: parameters)
            urlRequest.httpBody = json
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return try await request(urlRequest: urlRequest)
        } catch {
            throw MSError.encodingError
        }
    }
    
    func request(urlRequest: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse,
               200...299 ~= response.statusCode
            else { throw MSError.badHttpRequest }
            return data
        } catch {
            throw MSError.networkConnection
        }
    }
}
