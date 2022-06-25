//
//  ImageLoader.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class ImageLoader: IImageLoader {
    
    private let imageCash: IImageCache
    
    init(imageCash: IImageCache) {
        self.imageCash = imageCash
    }
    
    func downloadImage(from url: URL, completion: @escaping ImageLoaderResponse) {
        if let image = imageCash[url] {
            completion(nil, image)
            return
        }

        getData(from: url) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(ImageLoaderCustomErrors.imageLoaderError, nil) // Можно дефолтную поставить
                return
            }
            
            self.imageCash[url] = image
            completion(nil, image)
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

