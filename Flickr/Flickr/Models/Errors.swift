//
//  Errors.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

enum ImageLoaderCustomErrors: Error {
    case imageLoaderError
    case emphtyImage
}

enum RequestError: Error {
    case decodeError
    case invalidURL
    case noResponseError
    case unexpectedStatusCode
    case unknownError
    case thisIsLastPage
}
