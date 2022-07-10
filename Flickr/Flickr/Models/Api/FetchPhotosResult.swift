//
//  FetchPhotosResult.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

struct FetchPhotosResult: Codable {
    let photos: FlickrPhotos

    enum CodingKeys: String, CodingKey {
        case photos
    }

    init(photos: FlickrPhotos) {
        self.photos = photos
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(photos, forKey: .photos)
    }
}

extension FetchPhotosResult {
    static func getFlickrPhotoStub(countOfPhotos: Int = 7) -> FetchPhotosResult {
        FetchPhotosResult(photos: FlickrPhotos.getFlickrPhotoStub(countOfPhotos: countOfPhotos))
    }
}
