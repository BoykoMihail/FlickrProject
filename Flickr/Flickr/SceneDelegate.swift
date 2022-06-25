//
//  SceneDelegate.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    lazy var flickrService = {
        FlickrService()
    }()
    
    lazy var imageCache = {
        ImageCache()
    }()
    
    lazy var imageLoader = {
        ImageLoader(imageCash: imageCache)
    }()
    
    lazy var galleryAssembly = {
        GalleryAssembly(flickrService: flickrService, imageLoader: imageLoader)
    }()
    
    lazy var prepareForLoadingService = {
        PrepareForLoadingService(cacheExexutor: flickrService,
                                 imageLoader: imageLoader)
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        prepareForLoadingService.prepareForLoading()
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [galleryAssembly.assembly()]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

