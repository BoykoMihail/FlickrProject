//
//  Endpoint.swift
//  Flickr
//
//  Created by m.a.boyko on 09.07.2022.
//

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [String: String]? { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var method: Method { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://api.flickr.com/"
    }
}
