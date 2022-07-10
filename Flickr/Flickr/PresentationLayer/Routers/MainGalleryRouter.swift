//
//  MainGalleryRouter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class MainGalleryRouter: IMainGalleryRouter {
    private let navigationController: UINavigationController
    private let detailsImageViewAssembly: IDetailsImageViewAssembly

    init(navigationController: UINavigationController,
         detailsImageViewAssembly: IDetailsImageViewAssembly) {
        self.navigationController = navigationController
        self.detailsImageViewAssembly = detailsImageViewAssembly
    }

    func moveToDetailsImageView(model: MainGalleryRouterModel) {
        let size = CGSize(width: model.size.width, height: model.size.height)

        let viewModel = DetailsViewModel(image: model.image,
                                         name: model.title,
                                         size: size)

        let detailsImageView = detailsImageViewAssembly.assembly(viewModel: viewModel)
        navigationController.pushViewController(detailsImageView, animated: true)
    }
}
