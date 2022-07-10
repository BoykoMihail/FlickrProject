//
//  ImageHelper.swift
//  Flickr
//
//  Created by Михаил Бойко on 10.07.2022.
//

import UIKit

final class ImageHelper: IImageHelper {
    private let imageLoader: IImageLoader
    
    init(imageLoader: IImageLoader) {
        self.imageLoader = imageLoader
    }

    func updatePhotosModel(flickrPhoto: [FlickrPhoto]) {
        flickrPhoto.forEach { photoModel in
            if let url = URL(string: photoModel.photoUrl) {
                Task(priority: .background) {
                    _ = try await getImageFor(url: url)
                }
            }
        }
    }
    
    func getImageFor(url: URL) async throws -> (UIImage) {
        guard let image = try await imageLoader.image(from: url) else {
            throw ImageLoaderCustomErrors.emphtyImage
        }

        return image
    }
}
