//
//  FlickrDependencyAssembly.swift
//  Flickr
//
//  Created by Михаил Бойко on 10.07.2022.
//

import UIKit

@MainActor
final class FlickrDependencyAssembly {
    lazy var navigationController = UINavigationController()

    private lazy var _flickrService = {
        FlickrService()
    }()
    
    lazy var flickrService: IFlickrService = {
        _flickrService
    }()
    
    lazy var cacheExexutor: CacheExexutor = {
        _flickrService
    }()

    lazy var imageCache: IImageCache = {
        ImageCache()
    }()

    lazy var imageLoader: IImageLoader = {
        ImageLoader(cache: imageCache)
    }()
    
    lazy var imageHelper: IImageHelper = {
        ImageHelper(imageLoader: imageLoader)
    }()

    lazy var detailsImageViewAssembly: IDetailsImageViewAssembly = {
        DetailsImageViewAssembly()
    }()

    lazy var paginatorHelper: IPaginatorHelper = {
        PaginatorHelper(flickrService: flickrService)
    }()

    lazy var galleryAssembly: IGalleryAssembly = {
        GalleryAssembly(paginatorHelper: paginatorHelper,
                        imageHelper: imageHelper,
                        router: mainGalleryRouter)
    }()

    lazy var mainGalleryRouter: IMainGalleryRouter = {
        MainGalleryRouter(navigationController: navigationController,
                          detailsImageViewAssembly: detailsImageViewAssembly)
    }()
    
    lazy var prepareForLoadingService = {
        PrepareForLoadingService(cacheExexutor: cacheExexutor,
                                 imageLoader: imageLoader)
    }()
}
