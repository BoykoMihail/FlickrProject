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
    
    func moveToDetailsImageView(viewModel: DetailsViewModel) {
        let detailsImageView = detailsImageViewAssembly.assembly(viewModel: viewModel)
        navigationController.pushViewController(detailsImageView, animated: true)
    }
}

