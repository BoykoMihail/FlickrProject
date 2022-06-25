//
//  SceneDelegate.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private let navigationController = UINavigationController()

    private lazy var flickrService = {
        FlickrService()
    }()
    
    private lazy var imageCache = {
        ImageCache()
    }()
    
    private lazy var imageLoader = {
        ImageLoader(imageCash: imageCache)
    }()
    
    private lazy var detailsImageViewAssembly = {
        DetailsImageViewAssembly()
    }()
    
    private lazy var galleryAssembly = {
        GalleryAssembly(flickrService: flickrService,
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
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        prepareForLoadingService.prepareForLoading()
        
        navigationController.viewControllers = [galleryAssembly.assembly()]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

