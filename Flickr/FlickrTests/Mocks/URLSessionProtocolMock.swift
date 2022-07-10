//
//  URLSessionProtocolMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 10.07.2022.
//

@testable import Flickr
import Foundation

final class URLSessionProtocolMock: URLSessionProtocol {
    var invokedData = false
    var invokedDataCount = 0
    var invokedDataParameters: (request: URLRequest, delegate: URLSessionTaskDelegate?)?
    var invokedDataParametersList = [(request: URLRequest, delegate: URLSessionTaskDelegate?)]()
    var stubbedDataResult: (Data, URLResponse)!
    var stubbedDataError: RequestError?

    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        invokedData = true
        invokedDataCount += 1
        invokedDataParameters = (request, delegate)
        invokedDataParametersList.append((request, delegate))
        if let error = stubbedDataError {
            throw error
        }
        return stubbedDataResult
    }
}
