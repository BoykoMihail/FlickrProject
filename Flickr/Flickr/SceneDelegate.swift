//
//  SceneDelegate.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    lazy var flickrService: IFlickrService = {
        FlickrService()
    }()
    
    lazy var imageLoader: IImageLoader = {
        ImageLoader()
    }()
    
    lazy var galleryAssembly: GalleryAssembly = {
        GalleryAssembly(flickrService: flickrService, imageLoader: imageLoader)
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [galleryAssembly.assembly()]

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

