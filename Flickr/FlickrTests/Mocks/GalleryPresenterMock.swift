//
//  GalleryPresenterMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

import UIKit
@testable import Flickr

class GalleryPresenterMock: IGalleryPresenter {

    var invokedTitleGetter = false
    var invokedTitleGetterCount = 0
    var stubbedTitle: String! = ""

    var title: String {
        invokedTitleGetter = true
        invokedTitleGetterCount += 1
        return stubbedTitle
    }

    var invokedCountOfPhotosGetter = false
    var invokedCountOfPhotosGetterCount = 0
    var stubbedCountOfPhotos: Int! = 0

    var countOfPhotos: Int {
        invokedCountOfPhotosGetter = true
        invokedCountOfPhotosGetterCount += 1
        return stubbedCountOfPhotos
    }

    var invokedViewDidLoad = false
    var invokedViewDidLoadCount = 0

    func viewDidLoad() {
        invokedViewDidLoad = true
        invokedViewDidLoadCount += 1
    }

    var invokedDidTapCell = false
    var invokedDidTapCellCount = 0
    var invokedDidTapCellParameters: (indexPath: Int, Void)?
    var invokedDidTapCellParametersList = [(indexPath: Int, Void)]()

    func didTapCell(indexPath: Int) {
        invokedDidTapCell = true
        invokedDidTapCellCount += 1
        invokedDidTapCellParameters = (indexPath, ())
        invokedDidTapCellParametersList.append((indexPath, ()))
    }

    var invokedGetCellHeight = false
    var invokedGetCellHeightCount = 0
    var invokedGetCellHeightParameters: (index: Int, viewWidth: CGFloat)?
    var invokedGetCellHeightParametersList = [(index: Int, viewWidth: CGFloat)]()
    var stubbedGetCellHeightResult: CGFloat!

    func getCellHeight(index: Int, viewWidth: CGFloat) -> CGFloat {
        invokedGetCellHeight = true
        invokedGetCellHeightCount += 1
        invokedGetCellHeightParameters = (index, viewWidth)
        invokedGetCellHeightParametersList.append((index, viewWidth))
        return stubbedGetCellHeightResult
    }

    var invokedGetCellViewModelFor = false
    var invokedGetCellViewModelForCount = 0
    var invokedGetCellViewModelForParameters: (index: Int, Void)?
    var invokedGetCellViewModelForParametersList = [(index: Int, Void)]()
    var stubbedGetCellViewModelForResult: ImageCellViewModel!

    func getCellViewModelFor(index: Int) -> ImageCellViewModel {
        invokedGetCellViewModelFor = true
        invokedGetCellViewModelForCount += 1
        invokedGetCellViewModelForParameters = (index, ())
        invokedGetCellViewModelForParametersList.append((index, ()))
        return stubbedGetCellViewModelForResult
    }
}
