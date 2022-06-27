//
//  ImageDetailViewMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

import UIKit
@testable import Flickr

class ImageDetailViewMock: IImageDetailView {

    var invokedUpdateImage = false
    var invokedUpdateImageCount = 0
    var invokedUpdateImageParameters: (image: UIImage, size: CGSize)?
    var invokedUpdateImageParametersList = [(image: UIImage, size: CGSize)]()

    func updateImage(with image: UIImage, size: CGSize) {
        invokedUpdateImage = true
        invokedUpdateImageCount += 1
        invokedUpdateImageParameters = (image, size)
        invokedUpdateImageParametersList.append((image, size))
    }

    var invokedUpdateLabel = false
    var invokedUpdateLabelCount = 0
    var invokedUpdateLabelParameters: (string: String, Void)?
    var invokedUpdateLabelParametersList = [(string: String, Void)]()

    func updateLabel(with string: String) {
        invokedUpdateLabel = true
        invokedUpdateLabelCount += 1
        invokedUpdateLabelParameters = (string, ())
        invokedUpdateLabelParametersList.append((string, ()))
    }
}
