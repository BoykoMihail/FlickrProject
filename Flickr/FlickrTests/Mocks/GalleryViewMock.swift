//
//  GalleryViewMock.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

@testable import Flickr
import Foundation

class GalleryViewMock: IGalleryView {
    var invokedUpdateData = false
    var invokedUpdateDataCount = 0

    func updateData() {
        invokedUpdateData = true
        invokedUpdateDataCount += 1
    }
}
