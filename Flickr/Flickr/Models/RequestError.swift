//
//  RequestError.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

enum RequestError: Error {
    case decodeError
    case invalidURL
    case noResponseError
    case unexpectedStatusCode
    case unknownError
    case thisIsLastPage
}
