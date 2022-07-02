//
//  ImageDetailViewPresenter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import Foundation

final class ImageDetailViewPresenter: IImageDetailViewPresenter {
    
    private let viewModel: DetailsViewModel
    
    weak var view: IImageDetailView? = nil
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
    
    func viewDidLoad() {
        guard let view = view else {
            return
        }
        
        let koef = viewModel.size.height/viewModel.size.width
        let currentHeight = koef*view.viewWidth

        view.updateImage(with: viewModel.image, width: view.viewWidth, height: currentHeight)
        view.updateLabel(with: viewModel.name)
    }
}
