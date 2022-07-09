//
//  CacheExexutorMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation
@testable import Flickr

class CacheExexutorMock: CacheExexutor {

    var invokedWarmUpCache = false
    var invokedWarmUpCacheCount = 0
    var invokedWarmUpCacheParameters: (perPage: Int, page: Int)?
    var invokedWarmUpCacheParametersList = [(perPage: Int, page: Int)]()
    var stubbedWarmUpCacheResult: CacheExexutorResponse!
    var invokedWarmUpCacheCallBack: (() -> ())?

    func warmUpCache(perPage: Int, page: Int) async -> CacheExexutorResponse{
        invokedWarmUpCache = true
        invokedWarmUpCacheCount += 1
        invokedWarmUpCacheParameters = (perPage, page)
        invokedWarmUpCacheParametersList.append((perPage, page))
        if let callBack = invokedWarmUpCacheCallBack {
            callBack()
        }
        return stubbedWarmUpCacheResult
    }
}
