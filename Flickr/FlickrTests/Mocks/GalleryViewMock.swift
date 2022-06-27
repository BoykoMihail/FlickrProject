//
//  GalleryViewMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

import Foundation
@testable import Flickr

class GalleryViewMock: IGalleryView {

    var invokedUpdateData = false
    var invokedUpdateDataCount = 0
    var callBackForUpdateDataExpectation: (() -> ())?

    func updateData() {
        invokedUpdateData = true
        invokedUpdateDataCount += 1
        callBackForUpdateDataExpectation?()
    }
}
