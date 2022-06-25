//
//  IImageCache.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

protocol IImageCache: AnyObject {
    func removeAll()

    subscript(_ url: URL) -> UIImage? { get set }
}
