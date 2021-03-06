//
//  ImageCacheMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 27.06.2022.
//

@testable import Flickr
import UIKit

class ImageCacheMock: IImageCache {
    var invokedSubscriptGetter = false
    var invokedSubscriptGetterCount = 0
    var invokedSubscriptGetterParameters: (url: URL, Void)?
    var invokedSubscriptGetterParametersList = [(url: URL, Void)]()
    var stubbedSubscriptResult: UIImage!
    var invokedSubscriptSetter = false
    var invokedSubscriptSetterCount = 0
    var invokedSubscriptSetterParameters: (url: URL, Void)?
    var invokedSubscriptSetterParametersList = [(url: URL, Void)]()
    var invokedSubscript: UIImage??
    var invokedSubscriptList = [UIImage?]()

    subscript(_ url: URL) -> UIImage? {
        get {
            invokedSubscriptGetter = true
            invokedSubscriptGetterCount += 1
            invokedSubscriptGetterParameters = (url, ())
            invokedSubscriptGetterParametersList.append((url, ()))
            return stubbedSubscriptResult
        }
        set {
            invokedSubscriptSetter = true
            invokedSubscriptSetterCount += 1
            invokedSubscriptSetterParameters = (url, ())
            invokedSubscriptSetterParametersList.append((url, ()))
            invokedSubscript = newValue
            invokedSubscriptList.append(newValue)
        }
    }

    var invokedRemoveAll = false
    var invokedRemoveAllCount = 0

    func removeAll() {
        invokedRemoveAll = true
        invokedRemoveAllCount += 1
    }
}
