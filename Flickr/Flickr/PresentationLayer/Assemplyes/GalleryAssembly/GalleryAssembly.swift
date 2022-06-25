//
//  GalleryAssembly.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class GalleryAssembly {
    
    private let flickrService: IFlickrService
    private let imageLoader: IImageLoader
    
    init(flickrService: IFlickrService,
         imageLoader: IImageLoader) {
        self.flickrService = flickrService
        self.imageLoader = imageLoader
    }
    
    func assembly() -> UIViewController {
        let controller = GalleryController()
        let presenter = GalleryPresenter(flickrService: flickrService,
                                         imageLoader: imageLoader)
        
        controller.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}

