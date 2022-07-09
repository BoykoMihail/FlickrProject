//
//  GalleryAssembly.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class GalleryAssembly {
    
    private let paginatorHelper: IPaginatorHelper
    private let imageLoader: IImageLoader
    private let router: IMainGalleryRouter
    
    init(paginatorHelper: IPaginatorHelper,
         imageLoader: IImageLoader,
         router: IMainGalleryRouter) {
        self.paginatorHelper = paginatorHelper
        self.imageLoader = imageLoader
        self.router = router
    }
    
    func assembly() -> UIViewController {
        let controller = GalleryController()
        let presenter = GalleryPresenter(paginatorHelper: paginatorHelper,
                                         imageLoader: imageLoader,
                                         router: router)
        controller.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}
