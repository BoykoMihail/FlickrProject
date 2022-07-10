//
//  IImageHelper.swift
//  Flickr
//
//  Created by Михаил Бойко on 10.07.2022.
//

import UIKit

protocol IImageHelper {
    func updatePhotosModel(flickrPhoto: [FlickrPhoto])
    
    func getImageFor(url: URL) async throws -> (UIImage)
}
