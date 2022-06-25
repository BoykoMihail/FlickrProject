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
                    imageUrls.forEach{
                        self?.imageLoader.downloadImage(from: $0) { _,_ in }
                    }
                }
            }
        }
    }
}
