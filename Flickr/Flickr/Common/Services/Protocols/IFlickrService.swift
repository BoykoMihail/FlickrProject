//
//  IFlickrService.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

typealias FlickrResponse = (Error?, [FlickrPhoto]?) -> Void

protocol IFlickrService {
    func fetchPhotos(onCompletion: @escaping FlickrResponse)
}
