//
//  GalleryAssemblyTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 27.06.2022.
//

import XCTest
@testable import Flickr

class GalleryAssemblyTest: XCTestCase {

    private var galleryAssembly: GalleryAssembly!
    
    private var flickrServiceMock: FlickrServiceMock!
    private var imageLoaderMock: ImageLoaderMock!
    private var mainGalleryRouterMock: MainGalleryRouterMock!
    
    override func setUp() {
        super.setUp()
        
        flickrServiceMock = FlickrServiceMock()
        imageLoaderMock = ImageLoaderMock()
        mainGalleryRouterMock = MainGalleryRouterMock()
        
        galleryAssembly = GalleryAssembly(
            flickrService: flickrServiceMock,
            imageLoader: imageLoaderMock,
            router: mainGalleryRouterMock
        )
    }
    
    override func tearDown() {
        super.tearDown()
        
        galleryAssembly = nil
        flickrServiceMock = nil
        imageLoaderMock = nil
        mainGalleryRouterMock = nil
    }

    func testAssembly() throws {
        // given
        
        // when
        let viewController = galleryAssembly.assembly()
        
        // then
        guard let galleryController = viewController as? GalleryController else {
            XCTFail("Assembler вернул не GalleryController")
            return
        }
        
        XCTAssertTrue(galleryController.presenter is GalleryPresenter)
    }
}
