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
        view?.updateImage(with: viewModel.image, size: viewModel.size)
        view?.updateLabel(with: viewModel.name)
    }
}
