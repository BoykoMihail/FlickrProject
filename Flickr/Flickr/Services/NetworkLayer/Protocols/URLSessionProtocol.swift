//
//  URLSessionProtocol.swift
//  Flickr
//
//  Created by Михаил Бойко on 10.07.2022.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}
