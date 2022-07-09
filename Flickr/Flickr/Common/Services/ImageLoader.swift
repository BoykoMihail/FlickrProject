//
//  ImageLoader.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

actor ImageLoader: IImageLoader {
    
    private var cache: IImageCache
    
    init(cache: IImageCache) {
        self.cache = cache
    }
    
    func image(from url: URL) async throws -> UIImage? {
        if let cachedImage = cache[url] {
            return cachedImage
        }
        
        do {
            let image = try await downloadImage(from: url)
            cache[url] = image
            return image
        } catch {
            cache[url] = nil
            throw error
        }
    }
    
    private func downloadImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200,
              let image = UIImage(data: data) else {
            throw ImageLoaderCustomErrors.imageLoaderError
        }
        
        return image
    }
}
