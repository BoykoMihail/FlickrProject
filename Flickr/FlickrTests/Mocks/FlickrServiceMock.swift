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
    var invokedFetchPhotosParameters: (perPage: Int, page: Int)?
    var invokedFetchPhotosParametersList = [(perPage: Int, page: Int)]()
    var stubbedFetchPhotosResult: FlickrResponse!

    func fetchPhotos(perPage: Int, page: Int) async -> FlickrResponse {
        invokedFetchPhotos = true
        invokedFetchPhotosCount += 1
        invokedFetchPhotosParameters = (perPage, page)
        invokedFetchPhotosParametersList.append((perPage, page))
        return stubbedFetchPhotosResult
    }
}
