//
//  ImageCacheTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 25.06.2022.
//

import XCTest
@testable import Flickr

class ImageCacheTest: XCTestCase {

    private var imageCacheTest: IImageCache!
    
    
    override func setUp() {
        super.setUp()
        
        imageCacheTest = ImageCache()
    }
    
    override func tearDown() {
        super.tearDown()
        
        imageCacheTest = nil
    }

    func testImageIsSave() throws {
        // given
        let image = UIImage()
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1111&extras=url_m&per_page=30&page=1&format=json&nojsoncallback=1"
        
        // when
        guard let url: URL = URL(string: urlString) else {
            XCTFail("Строка не сконвертировалась в URL")
            return
        }
        
        imageCacheTest[url] = image
        
        // then
        let expectedImage = imageCacheTest[url]
        XCTAssertEqual(expectedImage, image)
    }
    
    func testRemovURL() throws {
        // given
        imageCacheTest = ImageCache()
        let image = UIImage()
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1111&extras=url_m&per_page=30&page=1&format=json&nojsoncallback=1"
        
        // when
        guard let url: URL = URL(string: urlString) else {
            XCTFail("Строка не сконвертировалась в URL")
            return
        }
        
        imageCacheTest[url] = image
        imageCacheTest[url] = nil
        
        // then
        let expectedImage = imageCacheTest[url]
        XCTAssertNil(expectedImage)
    }
    
    func testRemovAll() throws {
        // given
        imageCacheTest = ImageCache()
        let image = UIImage()
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1111&extras=url_m&per_page=30&page=1&format=json&nojsoncallback=1"
        
        // when
        guard let url: URL = URL(string: urlString) else {
            XCTFail("Строка не сконвертировалась в URL")
            return
        }
        
        imageCacheTest[url] = image
        imageCacheTest.removeAll()
        
        // then
        let expectedImage = imageCacheTest[url]
        XCTAssertNil(expectedImage)
    }
}
