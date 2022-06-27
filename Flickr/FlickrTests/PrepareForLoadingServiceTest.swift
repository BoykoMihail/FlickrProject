//
//  PrepareForLoadingServiceTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 25.06.2022.
//

import XCTest
@testable import Flickr

class PrepareForLoadingServiceTest: XCTestCase {

    private var prepareForLoadingService: PrepareForLoadingService!
    private var cacheExexutorMock: CacheExexutorMock!
    private var imageLoaderMock: ImageLoaderMock!
    
    override func setUp() {
        super.setUp()
        
        cacheExexutorMock = CacheExexutorMock()
        imageLoaderMock = ImageLoaderMock()
        prepareForLoadingService = PrepareForLoadingService(cacheExexutor: cacheExexutorMock,
                                                            imageLoader: imageLoaderMock)
    }
    
    override func tearDown() {
        super.tearDown()
        
        prepareForLoadingService = nil
        cacheExexutorMock = nil
        imageLoaderMock = nil
    }
    
    func testCallWarmUpCache() throws {
        // given
        let expectation = expectation(description: "WarmUpCache")

        // when
        cacheExexutorMock.stubbedWarmUpCacheOnCompletionResult = (nil, ())
        prepareForLoadingService.prepareForLoading()
        cacheExexutorMock.callBackForWarmUpCacheExpectation = {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        // then
        XCTAssertTrue(cacheExexutorMock.invokedWarmUpCache)
    }
    
    func testDownloadImage() throws {
        // given
        let urlString: String = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1111&extras=url_m&per_page=30&page=1&format=json&nojsoncallback=1"
        let expectation = expectation(description: "DownloadImage")

        guard let url: URL = URL(string: urlString) else {
            XCTFail("Строка не сконвертировалась в URL")
            return
        }
        
        cacheExexutorMock.stubbedWarmUpCacheOnCompletionResult = ([url], ())
        imageLoaderMock.stubbedDownloadImageCompletionResult = (nil, UIImage())
        imageLoaderMock.callBackForDownloadImageExpectation = {
            expectation.fulfill()
        }
        // when
        prepareForLoadingService.prepareForLoading()
        wait(for: [expectation], timeout: 1.0)

        // then
        XCTAssertTrue(imageLoaderMock.invokedDownloadImage)
        XCTAssertEqual(imageLoaderMock.invokedDownloadImageCount, 1)
        XCTAssertEqual(imageLoaderMock.invokedDownloadImageParameters?.url, url)
    }
}
