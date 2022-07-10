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
    private var imageHelperMock: ImageHelperMock!
    private var mainGalleryRouter: MainGalleryRouterMock!
    private var galleryViewMock: GalleryViewMock!

    @MainActor override func setUp() {
        super.setUp()

        paginatorHelperMock = PaginatorHelperMock()
        imageHelperMock = ImageHelperMock()
        mainGalleryRouter = MainGalleryRouterMock()
        galleryViewMock = GalleryViewMock()

        galleryPresenter = GalleryPresenter(
            paginatorHelper: paginatorHelperMock,
            imageHelper: imageHelperMock,
            router: mainGalleryRouter)

        galleryPresenter.viewController = galleryViewMock
    }

    func testCallFetchPhotos() async throws {
        // given
        let predicate = NSPredicate { _, _ in
            return self.paginatorHelperMock.invokedLoadInitialData == true
        }
        let testCallFetchPhotosExpectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: paginatorHelperMock
        )

        paginatorHelperMock.stubbedLoadInitialDataResult = []

        // when
        await galleryPresenter.viewDidLoad()

        wait(for: [testCallFetchPhotosExpectation], timeout: 3.0)
        // then
        XCTAssertTrue(paginatorHelperMock.invokedLoadInitialData)
    }

    func testUpdatePhotosAfterLoadPhotos() async throws {
        // given
        let predicate = NSPredicate { _, _ in
            return self.paginatorHelperMock.invokedLoadInitialData == true
        }
        let testUpdatePhotosAfterLoadPhotosExpectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: paginatorHelperMock
        )

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
        
        wait(for: [testUpdatePhotosAfterLoadPhotosExpectation], timeout: 3.0)
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
        let predicate = NSPredicate { _, _ in
            return self.imageHelperMock.invokedUpdatePhotosModel == true
        }
        
        let testCallDownloadImageExpectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: imageHelperMock
        )

        let photos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1")
        ]
        paginatorHelperMock.stubbedLoadInitialDataResult = photos
        imageHelperMock.stubbedGetImageForError = RequestError.unknownError

        // when
        await galleryPresenter.viewDidLoad()
        wait(for: [testCallDownloadImageExpectation], timeout: 3.0)

        // then
        XCTAssertTrue(imageHelperMock.invokedUpdatePhotosModel)
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
