//
//  FlickrPhotos.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

struct FlickrPhotos: Decodable {
    let photo: [FlickrPhoto]
    let page: Int
    let pages: Int

    enum CodingKeys: String, CodingKey {
        case photo
        case page
        case pages
    }

    init(photo: [FlickrPhoto], page: Int, pages: Int) {
        self.photo = photo
        self.page = page
        self.pages = pages
    }
}

extension FlickrPhotos {
    static func getFlickrPhotoStub(countOfPhotos: Int) -> FlickrPhotos {
        var photos = [FlickrPhoto]()
        (0..<countOfPhotos).forEach {
            let photo = FlickrPhoto.getFlickrPhotoStub(photoId: "\($0)",
                                                       title: "title \($0)")
            photos.append(photo)
        }
        return FlickrPhotos(photo: photos, page: 0, pages: 2)
    }
}
