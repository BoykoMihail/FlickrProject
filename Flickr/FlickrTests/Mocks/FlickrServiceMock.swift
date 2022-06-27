//
//  FlickrServiceMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

import Foundation
@testable import Flickr

class FlickrServiceMock: IFlickrService {

    var invokedFetchPhotos = false
    var invokedFetchPhotosCount = 0
    var stubbedFetchPhotosOnCompletionResult: (Error?, [FlickrPhoto]?)?

    func fetchPhotos(onCompletion: @escaping FlickrResponse) {
        invokedFetchPhotos = true
        invokedFetchPhotosCount += 1
        if let result = stubbedFetchPhotosOnCompletionResult {
            onCompletion(result.0, result.1)
        }
    }
}
