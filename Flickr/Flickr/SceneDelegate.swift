//
//  SceneDelegate.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    var flickrDependencyAssembly = FlickrDependencyAssembly()
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        flickrDependencyAssembly.prepareForLoadingService.prepareForLoading()
        
        window?.rootViewController = GlobalAssembly(flickrDependencyAssembly: flickrDependencyAssembly).assembly()
        window?.makeKeyAndVisible()
    }
}
