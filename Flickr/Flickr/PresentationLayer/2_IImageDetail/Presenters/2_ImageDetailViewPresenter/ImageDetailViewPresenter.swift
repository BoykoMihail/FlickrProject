//
//  ImageDetailViewPresenter.swift
//  Flickr
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit

final class ImageDetailViewPresenter: IImageDetailViewPresenter {
    private let viewModel: DetailsViewModel

    weak var view: IImageDetailView?

    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }

    @MainActor func viewDidLoad() {
        guard let view = view else {
            return
        }

        let koef = viewModel.size.height / viewModel.size.width
        let currentHeight = koef * view.viewWidth
        let size = CGSize(width: view.viewWidth,
                          height: currentHeight)
        view.updateImage(with: viewModel.image,
                         size: size)
        view.updateLabel(with: viewModel.name)
    }
}
