//
//  GalleryPresenterTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

@testable import Flickr
import XCTest

class GalleryPresenterTest: XCTestCase {
    private var galleryPresenter: GalleryPresenter!

    private var paginatorHelperMock: PaginatorHelperMock!
    private var imageLoaderMock: ImageLoaderMock!
    private var mainGalleryRouter: MainGalleryRouterMock!
    private var galleryViewMock: GalleryViewMock!

    @MainActor override func setUp() {
        super.setUp()

        paginatorHelperMock = PaginatorHelperMock()
        imageLoaderMock = ImageLoaderMock()
        mainGalleryRouter = MainGalleryRouterMock()
        galleryViewMock = GalleryViewMock()

        galleryPresenter = GalleryPresenter(
            paginatorHelper: paginatorHelperMock,
            imageLoader: imageLoaderMock,
            router: mainGalleryRouter)

        galleryPresenter.viewController = galleryViewMock
    }

    func testCallFetchPhotos() async throws {
        // given
        let predicate = NSPredicate { _, _ -> Bool in
            return self.paginatorHelperMock.invokedLoadInitialData == true
        }
        let publishExpectation = XCTNSPredicateExpectation(predicate: predicate, object: paginatorHelperMock)

        paginatorHelperMock.stubbedLoadInitialDataResult = []

        // when
        await galleryPresenter.viewDidLoad()

        wait(for: [publishExpectation], timeout: 3.0)
        // then
        XCTAssertTrue(paginatorHelperMock.invokedLoadInitialData)
    }

    func testUpdatePhotosAfterLoadPhotos() async throws {
        // given
        let predicate = NSPredicate { _, _ -> Bool in
            return self.paginatorHelperMock.invokedLoadInitialData == true
        }
        let publishExpectation = XCTNSPredicateExpectation(predicate: predicate, object: paginatorHelperMock)

        let photos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "2"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "3"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "4"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "5")
        ]
        paginatorHelperMock.stubbedLoadInitialDataResult = photos

        // when
        await galleryPresenter.viewDidLoad()
        
        wait(for: [publishExpectation], timeout: 3.0)
        // then
        XCTAssertEqual(galleryPresenter.countOfPhotos, photos.count)
    }

    func testUpdatePhotosAfterLoadPhotosError() async throws {
        // given

        paginatorHelperMock.stubbedLoadInitialDataError = RequestError.unknownError

        // when
        await galleryPresenter.viewDidLoad()

        // then
        XCTAssertEqual(galleryPresenter.countOfPhotos, 0)
    }

    func testCallDownloadImageFromLoadPhotos() async throws {
        // given
        let expectation = expectation(description: "testCallDownloadImageFromLoadPhotos")

        let photos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1")
        ]
        paginatorHelperMock.stubbedLoadInitialDataResult = photos
        imageLoaderMock.stubbedImageError = RequestError.unknownError

        imageLoaderMock.invokedImageCallBack = {
            expectation.fulfill()
        }

        // when
        await galleryPresenter.viewDidLoad()
        wait(for: [expectation], timeout: 1.0)

        // then
        XCTAssertTrue(imageLoaderMock.invokedImage)
    }

    @MainActor func testDidTapCellLogicWithoutImage() async throws {
        // given

        let photos: [FlickrPhoto] = []
        paginatorHelperMock.stubbedLoadInitialDataResult = photos

        // when
        await galleryPresenter.viewDidLoad()
        galleryPresenter.didTapCell(indexPath: 0)

        // then
        XCTAssertFalse(mainGalleryRouter.invokedMoveToDetailsImageView)
    }
}
