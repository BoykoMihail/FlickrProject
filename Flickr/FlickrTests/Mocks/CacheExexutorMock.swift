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
    var stubbedWarmUpCacheOnCompletionResult: ([URL]?, Void)?
    var callBackForWarmUpCacheExpectation: (() -> ())?

    func warmUpCache(onCompletion: @escaping CacheExexutorResponse) {
        invokedWarmUpCache = true
        invokedWarmUpCacheCount += 1
        
        if let result = stubbedWarmUpCacheOnCompletionResult {
            onCompletion(result.0)
            callBackForWarmUpCacheExpectation?()
        }
    }
}
