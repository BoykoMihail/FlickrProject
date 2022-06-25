//
//  PrepareForLoadingService.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

final class PrepareForLoadingService {
    
    let flickrService: CacheExexutor
    let imageLoader: IImageLoader
    
    init(flickrService: CacheExexutor,
         imageLoader: IImageLoader) {
        self.flickrService = flickrService
        self.imageLoader = imageLoader
    }
    
    func prepareForLoading() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.flickrService.warmUpCache { [weak self] imageUrls in
                if let imageUrls = imageUrls {
                    imageUrls.forEach{
                        self?.imageLoader.downloadImage(from: $0) { _,_ in }
                    }
                }
            }
        }
    }
}
