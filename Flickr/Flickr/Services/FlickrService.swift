//
//  FlickrService.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

final class FlickrService: HTTPClient, IFlickrService {    
    let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchPhotos(perPage: Int, page: Int) async throws -> FlickrResponse {
        #if DEBUG
        let uiTesting = ProcessInfo.processInfo.arguments.contains("Testing")

        guard !uiTesting else {
            return FetchPhotosResult.getFlickrPhotoStub()
        }
        #endif

        return try await sendRequest(
            endpoint: PhotosEndpoint.getRecent(perPage: perPage, page: page),
            responseModel: FetchPhotosResult.self
        )
    }
}

extension FlickrService: CacheExexutor {
    func warmUpCache(perPage: Int, page: Int) async -> CacheExexutorResponse {
        do {
            let flickrPhotoResult = try await fetchPhotos(perPage: perPage, page: page)
            return flickrPhotoResult.photos.photo.compactMap { $0.url }
        } catch {
            return nil
        }
    }
}
