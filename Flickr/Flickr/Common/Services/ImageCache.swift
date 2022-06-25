//
//  ImageCache.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

private extension Int {
    static let defaultCountLimit = 300
}

final class ImageCache {
    
    private let concurrentCashQueue = DispatchQueue(label: "gallerypresenter.concurrent.cash.queue", attributes: .concurrent)

    private lazy var imageCache: NSCache<AnyObject, UIImage> = {
        let cache = NSCache<AnyObject, UIImage>()
        cache.countLimit = countLimit
        return cache
    }()
    
    private let countLimit: Int

    init(countLimit: Int = Int.defaultCountLimit) {
        self.countLimit = countLimit
    }
}


extension ImageCache: IImageCache {
    
    func removeAll() {
        concurrentCashQueue.async(flags: .barrier) {
            self.imageCache.removeAllObjects()
        }
    }
    
    private func insert(_ image: UIImage?, for url: URL) {
        guard let image = image else {
            return remove(for: url)
        }
    
        concurrentCashQueue.async(flags: .barrier) {
            self.imageCache.setObject(image, forKey: url as AnyObject)
        }
    }

    private func remove(for url: URL) {
        concurrentCashQueue.async(flags: .barrier) {
            self.imageCache.removeObject(forKey: url as AnyObject)
        }
    }
    
    private func image(for url: URL) -> UIImage? {
        var image: UIImage? = nil
        
        concurrentCashQueue.sync {
            image = self.imageCache.object(forKey: url as AnyObject)
        }
        
        if let image = image {
            return image
        }
        
        return nil
    }
}


extension ImageCache {
    subscript(_ key: URL) -> UIImage? {
        get {
            image(for: key)
        }
        
        set {
            insert(newValue, for: key)
        }
    }
}
