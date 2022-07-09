//
//  IImageLoader.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

protocol IImageLoader {
    func image(from url: URL) async throws -> UIImage?
}
