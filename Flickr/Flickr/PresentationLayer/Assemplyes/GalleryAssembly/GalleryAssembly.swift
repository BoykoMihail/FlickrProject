//
//  GalleryAssembly.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class GalleryAssembly {
    
    func assembly() -> UIViewController {
        let controller = GalleryController()
        let presenter = GalleryPresenter()
        
        controller.presenter = presenter
        presenter.viewController = controller
        
        return controller
    }
}

