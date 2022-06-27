//
//  ImageLoaderMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 25.06.2022.
//

import UIKit
@testable import Flickr

class ImageLoaderMock: IImageLoader {

    var invokedDownloadImage = false
    var invokedDownloadImageCount = 0
    var invokedDownloadImageParameters: (url: URL, Void)?
    var invokedDownloadImageParametersList = [(url: URL, Void)]()
    var stubbedDownloadImageCompletionResult: (Error?, UIImage?)?
    var callBackForDownloadImageExpectation: (() -> ())?

    func downloadImage(from url: URL, completion: @escaping ImageLoaderResponse) {
        invokedDownloadImage = true
        invokedDownloadImageCount += 1
        invokedDownloadImageParameters = (url, ())
        invokedDownloadImageParametersList.append((url, ()))
        if let result = stubbedDownloadImageCompletionResult {
            completion(result.0, result.1)
            callBackForDownloadImageExpectation?()
        }
    }
}
