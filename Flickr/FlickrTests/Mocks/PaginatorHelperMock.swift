//
//  PaginatorHelperMock.swift
//  FlickrTests
//
//  Created by m.a.boyko on 09.07.2022.
//

@testable import Flickr
import UIKit

class PaginatorHelperMock: IPaginatorHelper {
    var invokedLoadInitialData = false
    var invokedLoadInitialDataCount = 0
    var stubbedLoadInitialDataResult: PaginatorHelperResult!
    var stubbedLoadInitialDataError: RequestError?

    func loadInitialData() async throws -> PaginatorHelperResult {
        invokedLoadInitialData = true
        invokedLoadInitialDataCount += 1

        if let error = stubbedLoadInitialDataError {
            throw error
        }
        return stubbedLoadInitialDataResult
    }

    var invokedLoadNextPage = false
    var invokedLoadNextPageCount = 0
    var stubbedLoadNextPageResult: PaginatorHelperResult!
    var stubbedLoadNextPageError: RequestError!

    func loadNextPage() async throws -> PaginatorHelperResult {
        invokedLoadNextPage = true
        invokedLoadNextPageCount += 1
        if let error = stubbedLoadNextPageError {
            throw error
        }
        return stubbedLoadNextPageResult
    }
}
