//
//  IFlickrService.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

typealias FlickrResponse = Result<FetchPhotosResult, RequestError>

protocol IFlickrService {
    func fetchPhotos(perPage: Int, page: Int) async -> FlickrResponse
}
