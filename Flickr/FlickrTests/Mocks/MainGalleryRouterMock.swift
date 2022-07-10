//
//  MainGalleryRouterMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

@testable import Flickr
import UIKit

class MainGalleryRouterMock: IMainGalleryRouter {
    var invokedMoveToDetailsImageView = false
    var invokedMoveToDetailsImageViewCount = 0
    var invokedMoveToDetailsImageViewParameters: (model: MainGalleryRouterModel, Void)?
    var invokedMoveToDetailsImageViewParametersList = [(model: MainGalleryRouterModel, Void)]()
    var invokedMoveToDetailsImageViewCallBack: (() -> Void)?

    func moveToDetailsImageView(model: MainGalleryRouterModel) {
        invokedMoveToDetailsImageView = true
        invokedMoveToDetailsImageViewCount += 1
        invokedMoveToDetailsImageViewParameters = (model, ())
        invokedMoveToDetailsImageViewParametersList.append((model, ()))
        if let callBack = invokedMoveToDetailsImageViewCallBack {
            callBack()
        }
    }
}
