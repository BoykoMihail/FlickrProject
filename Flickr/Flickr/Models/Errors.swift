//
//  Errors.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

enum FlickrServiceCustomErrors: Error {
    case thisIsLastPage
    case wrongURL
    case ephtyData
    case decodeError
}

enum ImageLoaderCustomErrors: Error {
    case imageLoaderError
    case emphtyImage
}
