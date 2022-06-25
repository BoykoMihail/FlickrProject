//
//  GalleryAssembly.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class GalleryAssembly {
    
    private let flickrService: IFlickrService
    
    init(flickrService: IFlickrService) {
        self.flickrService = flickrService
    }
    
    func assembly() -> UIViewController {
        let controller = GalleryController()
        let presenter = GalleryPresenter(flickrService: flickrService)
        
        controller.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}

