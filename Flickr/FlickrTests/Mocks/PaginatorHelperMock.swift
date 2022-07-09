//
//  PaginatorHelperMock.swift
//  FlickrTests
//
//  Created by m.a.boyko on 09.07.2022.
//

import UIKit
@testable import Flickr

class PaginatorHelperMock: IPaginatorHelper {

    var invokedLoadInitialData = false
    var invokedLoadInitialDataCount = 0
    var stubbedLoadInitialDataResult: PaginatorHelperResult!
    var invokedLoadInitialDataCallBack: (() -> ())?

    func loadInitialData() async -> PaginatorHelperResult {
        invokedLoadInitialData = true
        invokedLoadInitialDataCount += 1
        if let callBack = invokedLoadInitialDataCallBack {
            callBack()
        }
        return stubbedLoadInitialDataResult
    }

    var invokedLoadNextPage = false
    var invokedLoadNextPageCount = 0
    var stubbedLoadNextPageResult: PaginatorHelperResult!

    func loadNextPage() async -> PaginatorHelperResult{
        invokedLoadNextPage = true
        invokedLoadNextPageCount += 1
        return stubbedLoadNextPageResult
    }
}
