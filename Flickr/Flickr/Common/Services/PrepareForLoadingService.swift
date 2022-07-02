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
        DispatchQueue.global(qos: .userInitiated).async {
            self.cacheExexutor.warmUpCache { [weak self] imageUrls in
                if let imageUrls = imageUrls {
                    DispatchQueue.concurrentPerform(iterations: imageUrls.count) { index in
                        self?.imageLoader.downloadImage(from: imageUrls[index]) { _,_ in }
                    }
                }
            }
        }
    }
}
