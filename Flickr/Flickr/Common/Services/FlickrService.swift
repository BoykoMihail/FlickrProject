//
//  FlickrService.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

actor FlickrService: HTTPClient, IFlickrService {
    
    func fetchPhotos(perPage: Int, page: Int) async -> FlickrResponse {
        let uiTesting = ProcessInfo.processInfo.arguments.contains("Testing")

        guard !uiTesting else {
            return .success(FetchPhotosResult.getFlickrPhotoStub())
        }
        
        return await sendRequest(endpoint: PhotosEndpoint.getRecent(perPage: perPage, page: page), responseModel: FetchPhotosResult.self)
    }
}

extension FlickrService: CacheExexutor {
    func warmUpCache(perPage: Int, page: Int) async -> CacheExexutorResponse {
        let flickrPhotoResult = await fetchPhotos(perPage: perPage, page: page)
        
        switch flickrPhotoResult {
        case let .success(results):
            return results.photos.photo.compactMap { URL(string: $0.photoUrl) }
        case .failure(_):
            return nil
        }
    }
}
