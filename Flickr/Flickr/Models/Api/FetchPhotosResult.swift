//
//  FetchPhotosResult.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

struct FetchPhotosResult: Decodable {
    
    let photos: FlickrPhotos
    
    enum CodingKeys: String, CodingKey {
        case photos
    }
    
    init(photos: FlickrPhotos) {
        self.photos = photos
    }
}

extension FetchPhotosResult {
    static func getFlickrPhotoStub() -> FetchPhotosResult {
        FetchPhotosResult(photos: FlickrPhotos.getFlickrPhotoStub(countOfPhotos: 7))
    }
}
