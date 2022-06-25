//
//  DetailsImageViewAssembly.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class DetailsImageViewAssembly: IDetailsImageViewAssembly {
    
    func assembly(viewModel: DetailsViewModel) -> UIViewController {
        let viewController = ImageDetailViewController()
        let presenter = ImageDetailViewPresenter(viewModel: viewModel)
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
}

