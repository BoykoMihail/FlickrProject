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

typealias PaginatorHelperResult = [FlickrPhoto]

actor PaginatorHelper: IPaginatorHelper {
    private let flickrService: IFlickrService

    private var currentPage = 1
    private var amountOfPages = 1

    init(flickrService: IFlickrService) {
        self.flickrService = flickrService
    }

    func loadInitialData() async throws -> PaginatorHelperResult {
        let fetchPhotosResult = try await flickrService.fetchPhotos(perPage: .perPage, page: 0)
        return getPaginatorHelperResultFrom(fetchPhotosResult)
    }

    func loadNextPage() async throws -> PaginatorHelperResult {
        let fetchPhotosResult = try await flickrService.fetchPhotos(perPage: .perPage, page: currentPage)
        return getPaginatorHelperResultFrom(fetchPhotosResult)
    }

    private func getPaginatorHelperResultFrom(_ flickrResponse: FlickrResponse) -> PaginatorHelperResult {
        updatePage(newAmountOfPages: flickrResponse.photos.pages)
        return flickrResponse.photos.photo
    }

    private func updatePage(newAmountOfPages: Int) {
        currentPage += 1
        amountOfPages = newAmountOfPages
    }
}
