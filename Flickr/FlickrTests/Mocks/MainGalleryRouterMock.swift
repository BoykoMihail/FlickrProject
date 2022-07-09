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
    var invokedMoveToDetailsImageViewParameters: (viewModel: FlickrPhoto, Void)?
    var invokedMoveToDetailsImageViewParametersList = [(viewModel: FlickrPhoto, Void)]()
    var invokedMoveToDetailsImageViewCallBack: (() -> ())?

    func moveToDetailsImageView(viewModel: FlickrPhoto) {
        invokedMoveToDetailsImageView = true
        invokedMoveToDetailsImageViewCount += 1
        invokedMoveToDetailsImageViewParameters = (viewModel, ())
        invokedMoveToDetailsImageViewParametersList.append((viewModel, ()))
        if let callBack = invokedMoveToDetailsImageViewCallBack {
            callBack()
        }
    }
}
