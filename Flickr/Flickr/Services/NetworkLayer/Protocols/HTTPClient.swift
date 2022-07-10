//
//  HTTPClient.swift
//  Flickr
//
//  Created by m.a.boyko on 09.07.2022.
//

import Foundation

protocol HTTPClient {
    var urlSession: URLSessionProtocol { get }
    
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint,
                                   responseModel: T.Type)  async throws -> T {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw RequestError.invalidURL
        }

        components.queryItems = endpoint.queryItems?.map({ (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        })

        guard let url = components.url else {
            throw RequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

        let (data, response) = try await urlSession.data(for: request, delegate: nil)
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.noResponseError
        }
        switch response.statusCode {
        case 200...299:
            guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                throw RequestError.decodeError
            }
            return decodedResponse
        default:
            throw RequestError.unexpectedStatusCode
        }
    }
}
