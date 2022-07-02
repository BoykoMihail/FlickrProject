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
    
    func moveToDetailsImageView(viewModel: FlickrPhoto) {
        guard let image = viewModel.image else {
            return
        }
        
        let size = CGSize(width: viewModel.width, height: viewModel.height)
        
        let viewModel = DetailsViewModel(image: image,
                                         name: viewModel.title,
                                         size: size)
        
        let detailsImageView = detailsImageViewAssembly.assembly(viewModel: viewModel)
        navigationController.pushViewController(detailsImageView, animated: true)
    }
}
