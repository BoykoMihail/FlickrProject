//
//  GalleryAssembly.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class GalleryAssembly: IGalleryAssembly {
    private let paginatorHelper: IPaginatorHelper
    private let imageHelper: IImageHelper
    private let router: IMainGalleryRouter

    init(paginatorHelper: IPaginatorHelper,
         imageHelper: IImageHelper,
         router: IMainGalleryRouter) {
        self.paginatorHelper = paginatorHelper
        self.imageHelper = imageHelper
        self.router = router
    }

    func assembly() -> UIViewController {
        let controller = GalleryController()
        let presenter = GalleryPresenter(paginatorHelper: paginatorHelper,
                                         imageHelper: imageHelper,
                                         router: router)
        controller.presenter = presenter
        presenter.viewController = controller

        return controller
    }
}
