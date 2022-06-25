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
    private let router: IMainGalleryRouter
    
    init(flickrService: IFlickrService,
         imageLoader: IImageLoader,
         router: IMainGalleryRouter) {
        self.flickrService = flickrService
        self.imageLoader = imageLoader
        self.router = router
    }
    
    func assembly() -> UIViewController {
        let controller = GalleryController()
        let presenter = GalleryPresenter(flickrService: flickrService,
                                         imageLoader: imageLoader,
                                         router: router)
        controller.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}
