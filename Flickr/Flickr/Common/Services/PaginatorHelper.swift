//
//  PaginatorHelper.swift
//  Flickr
//
//  Created by m.a.boyko on 09.07.2022.
//

import Foundation

private extension Int {
    static let perPage = 30
}

typealias PaginatorHelperResult = Result<[FlickrPhoto], RequestError>

actor PaginatorHelper: IPaginatorHelper {
    
    private let flickrService: IFlickrService
    
    private var currentPage = 1
    private var amountOfPages = 1
    
    init(flickrService: IFlickrService) {
        self.flickrService = flickrService
    }
    
    func loadInitialData() async -> PaginatorHelperResult {
        let fetchPhotosResult = await flickrService.fetchPhotos(perPage: .perPage, page: 0)
        return getPaginatorHelperResultFrom(fetchPhotosResult)
    }
    
    func loadNextPage() async -> PaginatorHelperResult {
        let fetchPhotosResult = await flickrService.fetchPhotos(perPage: .perPage, page: currentPage)
        return getPaginatorHelperResultFrom(fetchPhotosResult)
    }
    
    private func getPaginatorHelperResultFrom(_ flickrResponse: FlickrResponse) -> PaginatorHelperResult {
        switch flickrResponse {
        case let .success(fetchPhotosResult):
            updatePage(newAmountOfPages: fetchPhotosResult.photos.pages)
            return .success(fetchPhotosResult.photos.photo)
        case let .failure(error):
            return .failure(error)
        }
    }
    
    private func updatePage(newAmountOfPages: Int) {
        currentPage+=1
        amountOfPages = newAmountOfPages
    }
    
}
