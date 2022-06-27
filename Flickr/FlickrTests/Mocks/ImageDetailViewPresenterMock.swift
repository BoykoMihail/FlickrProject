//
//  ImageDetailViewPresenterMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

import Foundation
@testable import Flickr

class ImageDetailViewPresenterMock: IImageDetailViewPresenter {

    var invokedViewDidLoad = false
    var invokedViewDidLoadCount = 0

    func viewDidLoad() {
        invokedViewDidLoad = true
        invokedViewDidLoadCount += 1
    }
}
