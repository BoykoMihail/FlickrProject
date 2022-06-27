//
//  GalleryPresenterMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

import UIKit
@testable import Flickr

class GalleryPresenterMock: IGalleryPresenter {

    var invokedPhotosGetter = false
    var invokedPhotosGetterCount = 0
    var stubbedPhotos: [FlickrPhoto]! = []

    var photos: [FlickrPhoto] {
        invokedPhotosGetter = true
        invokedPhotosGetterCount += 1
        return stubbedPhotos
    }

    var invokedViewDidLoad = false
    var invokedViewDidLoadCount = 0

    func viewDidLoad() {
        invokedViewDidLoad = true
        invokedViewDidLoadCount += 1
    }

    var invokedLoadPhotos = false
    var invokedLoadPhotosCount = 0
    var callBackForLoadPhotosExpectation: (() -> ())?
    
    func loadPhotos() {
        invokedLoadPhotos = true
        invokedLoadPhotosCount += 1
        callBackForLoadPhotosExpectation?()
    }

    var invokedGetImageFor = false
    var invokedGetImageForCount = 0
    var invokedGetImageForParameters: (index: Int, Void)?
    var invokedGetImageForParametersList = [(index: Int, Void)]()
    var stubbedGetImageForCompletionResult: (UIImage, Void)?
    var callBackForGetImageForExpectation: (() -> ())?

    func getImageFor(index: Int, completion: @escaping (UIImage) -> ()) {
        invokedGetImageFor = true
        invokedGetImageForCount += 1
        invokedGetImageForParameters = (index, ())
        invokedGetImageForParametersList.append((index, ()))
        callBackForGetImageForExpectation?()
        if let result = stubbedGetImageForCompletionResult {
            completion(result.0)
        }
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

    var invokedClearImage = false
    var invokedClearImageCount = 0
    var invokedClearImageParameters: (index: Int, Void)?
    var invokedClearImageParametersList = [(index: Int, Void)]()
    var callBackForClearImageExpectation: (() -> ())?

    func clearImage(index: Int) {
        invokedClearImage = true
        invokedClearImageCount += 1
        invokedClearImageParameters = (index, ())
        invokedClearImageParametersList.append((index, ()))
        callBackForClearImageExpectation?()
    }
}
