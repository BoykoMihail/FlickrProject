//
//  ImageLoaderTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 27.06.2022.
//

import XCTest
@testable import Flickr

private extension UIImage {
    static let defaultTestImage = UIImage()
}

class ImageLoaderTest: XCTestCase {

    private var imageLoader: ImageLoader!
    
    private var imageCacheMock: ImageCacheMock!
    
    override func setUp() {
        super.setUp()
        
        imageCacheMock = ImageCacheMock()
        imageLoader = ImageLoader(imageCache: imageCacheMock)
    }
    
    override func tearDown() {
        super.tearDown()
        
        imageLoader = nil
        imageCacheMock = nil
    }

    func testDownloadImageFromCache() throws {
        // given
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1111&extras=url_m&per_page=30&page=1&format=json&nojsoncallback=1"
        imageCacheMock.stubbedSubscriptResult = .defaultTestImage
        let expectation = expectation(description: "DownloadImage")

        // when
        guard let url: URL = URL(string: urlString) else {
            XCTFail("Строка не сконвертировалась в URL")
            return
        }
        
        var resultImage: UIImage?
        var resultError: Error?
        // when
        imageLoader.downloadImage(from: url) { error, image  in
            resultError = error
            resultImage = image
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        // then
        
        XCTAssert(imageCacheMock.invokedSubscriptGetter)
        XCTAssertNil(resultError)
        XCTAssertNotNil(resultImage)
        XCTAssertEqual(resultImage, .defaultTestImage)
    }
    
    func testDownloadImageError() throws {
        // given
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1111&extras=url_m&per_page=30&page=1&format=json&nojsoncallback=1"
        let expectation = expectation(description: "DownloadImage")

        // when
        guard let url: URL = URL(string: urlString) else {
            XCTFail("Строка не сконвертировалась в URL")
            return
        }
        
        var resultImage: UIImage?
        var resultError: Error?
        // when
        imageLoader.downloadImage(from: url) { error, image  in
            resultError = error
            resultImage = image
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        // then
        
        XCTAssert(imageCacheMock.invokedSubscriptGetter)
        XCTAssertNotNil(resultError)
        XCTAssertNil(resultImage)
        XCTAssert(resultError is ImageLoaderCustomErrors)
    }
}
