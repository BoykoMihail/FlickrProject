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
}
