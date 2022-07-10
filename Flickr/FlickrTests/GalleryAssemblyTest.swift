//
//  GalleryAssemblyTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 27.06.2022.
//

@testable import Flickr
import XCTest

class GalleryAssemblyTest: XCTestCase {
    private var galleryAssembly: GalleryAssembly!

    private var paginatorHelperMock: PaginatorHelperMock!
    private var imageHelperMock: ImageHelperMock!
    private var mainGalleryRouterMock: MainGalleryRouterMock!

    @MainActor override func setUp() {
        super.setUp()

        paginatorHelperMock = PaginatorHelperMock()
        imageHelperMock = ImageHelperMock()
        mainGalleryRouterMock = MainGalleryRouterMock()

        galleryAssembly = GalleryAssembly(
            paginatorHelper: paginatorHelperMock,
            imageHelper: imageHelperMock,
            router: mainGalleryRouterMock
        )
    }

    override func tearDown() {
        super.tearDown()

        galleryAssembly = nil
        paginatorHelperMock = nil
        imageHelperMock = nil
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
