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
        imageLoader = ImageLoader(cache: imageCacheMock)
    }
    
    override func tearDown() {
        super.tearDown()
        
        imageLoader = nil
        imageCacheMock = nil
    }

    func testDownloadImageFromCache() async throws {
        // given
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1111&extras=url_m&per_page=30&page=1&format=json&nojsoncallback=1"
        imageCacheMock.stubbedSubscriptResult = .defaultTestImage

        // when
        guard let url: URL = URL(string: urlString) else {
            XCTFail("Строка не сконвертировалась в URL")
            return
        }
        
        // when
        let result = try await imageLoader.image(from: url)
        
        // then
        
        XCTAssert(imageCacheMock.invokedSubscriptGetter)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result, .defaultTestImage)
    }
    
    func testDownloadImageError() async throws {
        // given
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1111&extras=url_m&per_page=30&page=1&format=json&nojsoncallback=1"

        // when
        guard let url: URL = URL(string: urlString) else {
            XCTFail("Строка не сконвертировалась в URL")
            return
        }
        
        // when
        
        do {
            let _ = try await imageLoader.image(from: url)
            XCTFail("Ожидалась ошибка")
        } catch {
            // then
            XCTAssert(imageCacheMock.invokedSubscriptGetter)
            XCTAssertNotNil(error)
            XCTAssert(error is ImageLoaderCustomErrors)
        }
    }
}
