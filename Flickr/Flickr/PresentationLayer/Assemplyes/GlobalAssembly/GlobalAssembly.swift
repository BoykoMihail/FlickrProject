//
//  GlobalAssembly.swift
//  Flickr
//
//  Created by m.a.boyko on 09.07.2022.
//

import UIKit

final class GlobalAssembly {
    
    private let navigationController = UINavigationController()

    private lazy var flickrService = {
        FlickrService()
    }()
    
    private lazy var imageCache = {
        ImageCache()
    }()
    
    private lazy var imageLoader = {
        ImageLoader(cache: imageCache)
    }()
    
    private lazy var detailsImageViewAssembly = {
        DetailsImageViewAssembly()
    }()
    
    private lazy var paginatorHelper = {
        PaginatorHelper(flickrService: flickrService)
    }()
    
    private lazy var galleryAssembly = {
        GalleryAssembly(paginatorHelper: paginatorHelper,
                        imageLoader: imageLoader,
                        router: mainGalleryRouter)
    }()
    
    private lazy var mainGalleryRouter = {
        MainGalleryRouter(navigationController: navigationController,
                          detailsImageViewAssembly: detailsImageViewAssembly)
    }()
    
    private lazy var prepareForLoadingService = {
        PrepareForLoadingService(cacheExexutor: flickrService,
                                 imageLoader: imageLoader)
    }()
    
    func assembly() -> UIViewController {
        prepareForLoadingService.prepareForLoading()
        
        navigationController.viewControllers = [galleryAssembly.assembly()]
        
        return navigationController
    }
}
