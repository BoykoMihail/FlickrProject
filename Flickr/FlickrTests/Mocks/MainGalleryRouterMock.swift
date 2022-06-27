//
//  MainGalleryRouterMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

import Foundation
@testable import Flickr

class MainGalleryRouterMock: IMainGalleryRouter {

    var invokedMoveToDetailsImageView = false
    var invokedMoveToDetailsImageViewCount = 0
    var invokedMoveToDetailsImageViewParameters: (viewModel: DetailsViewModel, Void)?
    var invokedMoveToDetailsImageViewParametersList = [(viewModel: DetailsViewModel, Void)]()

    func moveToDetailsImageView(viewModel: DetailsViewModel) {
        invokedMoveToDetailsImageView = true
        invokedMoveToDetailsImageViewCount += 1
        invokedMoveToDetailsImageViewParameters = (viewModel, ())
        invokedMoveToDetailsImageViewParametersList.append((viewModel, ()))
    }
}
