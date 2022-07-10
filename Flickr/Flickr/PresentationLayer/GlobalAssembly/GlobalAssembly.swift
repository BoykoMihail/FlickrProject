//
//  GlobalAssembly.swift
//  Flickr
//
//  Created by m.a.boyko on 09.07.2022.
//

import UIKit

@MainActor
final class GlobalAssembly {
    var flickrDependencyAssembly: FlickrDependencyAssembly
    
    init(flickrDependencyAssembly: FlickrDependencyAssembly) {
        self.flickrDependencyAssembly = flickrDependencyAssembly
    }
    
    func assembly() -> UIViewController {
        let navigationController = flickrDependencyAssembly.navigationController
        navigationController.viewControllers = [flickrDependencyAssembly.galleryAssembly.assembly()]

        return navigationController
    }
}
