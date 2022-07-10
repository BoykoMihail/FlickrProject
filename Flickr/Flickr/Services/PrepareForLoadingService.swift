//
//  PrepareForLoadingService.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

final class PrepareForLoadingService {
    let cacheExexutor: CacheExexutor
    let imageLoader: IImageLoader

    init(cacheExexutor: CacheExexutor,
         imageLoader: IImageLoader) {
        self.cacheExexutor = cacheExexutor
        self.imageLoader = imageLoader
    }

    func prepareForLoading() {
        Task(priority: .background) {
            let imageUrls = await cacheExexutor.warmUpCache(perPage: 200,
                                                            page: 0)
            if let imageUrls = imageUrls {
                imageUrls.forEach { url in
                    Task(priority: .background) {
                        do {
                            _ = try await imageLoader.image(from: url)
                        } catch { }
                    }
                }
            }
        }
    }
}
