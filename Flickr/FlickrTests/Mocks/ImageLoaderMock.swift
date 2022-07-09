//
//  ImageLoaderMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit
@testable import Flickr

class ImageLoaderMock: IImageLoader {

    var invokedImage = false
    var invokedImageCount = 0
    var invokedImageParameters: (url: URL, Void)?
    var invokedImageParametersList = [(url: URL, Void)]()
    var stubbedImageResult: UIImage!
    var stubbedImageError: Error?
    var invokedImageCallBack: (() -> ())?

    func image(from url: URL) async throws -> UIImage? {
        invokedImage = true
        invokedImageCount += 1
        invokedImageParameters = (url, ())
        invokedImageParametersList.append((url, ()))
        if let callBack = invokedImageCallBack {
            callBack()
        }
        
        if let error = stubbedImageError {
            throw error
        }
        
        return stubbedImageResult
    }
}
