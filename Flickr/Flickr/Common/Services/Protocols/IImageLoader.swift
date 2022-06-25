//
//  IImageLoader.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

typealias ImageLoaderResponse = (Error?, UIImage?) -> Void

protocol IImageLoader {
    func downloadImage(from url: URL, completion: @escaping ImageLoaderResponse)
}
