//
//  IFlickrService.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

typealias FlickrResponse = FetchPhotosResult

protocol IFlickrService {
    func fetchPhotos(perPage: Int, page: Int) async throws -> FlickrResponse
}
