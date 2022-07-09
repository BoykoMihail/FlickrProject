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
    
    private var paginatorHelperMock: PaginatorHelperMock!
    private var imageLoaderMock: ImageLoaderMock!
    private var mainGalleryRouterMock: MainGalleryRouterMock!
    
    override func setUp() {
        super.setUp()
        
        paginatorHelperMock = PaginatorHelperMock()
        imageLoaderMock = ImageLoaderMock()
        mainGalleryRouterMock = MainGalleryRouterMock()
        
        galleryAssembly = GalleryAssembly(
            paginatorHelper: paginatorHelperMock,
            imageLoader: imageLoaderMock,
            router: mainGalleryRouterMock
        )
    }
    
    override func tearDown() {
        super.tearDown()
        
        galleryAssembly = nil
        paginatorHelperMock = nil
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
