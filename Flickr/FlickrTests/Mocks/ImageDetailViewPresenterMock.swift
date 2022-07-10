//
//  ImageDetailViewPresenterMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

@testable import Flickr
import Foundation

class ImageDetailViewPresenterMock: IImageDetailViewPresenter {
    var invokedViewDidLoad = false
    var invokedViewDidLoadCount = 0

    func viewDidLoad() {
        invokedViewDidLoad = true
        invokedViewDidLoadCount += 1
    }
}
