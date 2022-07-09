//
//  GalleryPresenterTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

import XCTest
@testable import Flickr

class GalleryPresenterTest: XCTestCase {

    private var galleryPresenter: GalleryPresenter!
    
    private var paginatorHelperMock: PaginatorHelperMock!
    private var imageLoaderMock: ImageLoaderMock!
    private var mainGalleryRouter: MainGalleryRouterMock!
    private var galleryViewMock: GalleryViewMock!

    override func setUp() {
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

    func testIsUpdatingLogic() throws {
        // given
        let expectation = expectation(description: "testIsUpdatingLogic")
        
        paginatorHelperMock.stubbedLoadInitialDataResult = .success([])
        
        // when
        galleryPresenter.viewDidLoad()
        galleryPresenter.viewDidLoad()
        galleryPresenter.viewDidLoad()
        paginatorHelperMock.invokedLoadInitialDataCallBack = {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        // then
        XCTAssertEqual(paginatorHelperMock.invokedLoadInitialDataCount, 1)
    }
    
    func testCallFetchPhotos() throws {
        // given
        let expectation = expectation(description: "testCallFetchPhotos")
        
        paginatorHelperMock.stubbedLoadInitialDataResult = .success([])
        
        // when
        galleryPresenter.viewDidLoad()
        paginatorHelperMock.invokedLoadInitialDataCallBack = {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        // then
        XCTAssertTrue(paginatorHelperMock.invokedLoadInitialData)
    }
    
    func testUpdatePhotosAfterLoadPhotos() throws {
        // given
        let expectation = expectation(description: "testUpdatePhotosAfterLoadPhotos")

        let photos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "2"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "3"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "4"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "5")
        ]
        paginatorHelperMock.stubbedLoadInitialDataResult = .success(photos)

        // when
        galleryPresenter.viewDidLoad()
        paginatorHelperMock.invokedLoadInitialDataCallBack = {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        // then
        XCTAssertEqual(galleryPresenter.countOfPhotos, photos.count)
    }
    
    func testUpdatePhotosAfterLoadPhotosError() throws {
        // given

        paginatorHelperMock.stubbedLoadInitialDataResult = .failure(RequestError.unknownError)
        
        // when
        galleryPresenter.viewDidLoad()
        
        // then
        XCTAssertEqual(galleryPresenter.countOfPhotos, 0)
    }
    
    func testCallViewUpdateData() throws {
        // given
        let expectation = expectation(description: "UpdateData")

        let photos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "2"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "3"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "4"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "5")
        ]
        paginatorHelperMock.stubbedLoadInitialDataResult = .success(photos)
        galleryViewMock.callBackForUpdateDataExpectation = {
            expectation.fulfill()
        }
        
        // when
        galleryPresenter.viewDidLoad()
        wait(for: [expectation], timeout: 1.0)
        
        // then
        XCTAssertTrue(galleryViewMock.invokedUpdateData)
    }
    
    func testCallDownloadImageFromLoadPhotos() throws {
        // given
        let expectation = expectation(description: "testCallDownloadImageFromLoadPhotos")

        let photos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1")
        ]
        paginatorHelperMock.stubbedLoadInitialDataResult = .success(photos)
        imageLoaderMock.stubbedImageError = RequestError.unknownError
        
        imageLoaderMock.invokedImageCallBack = {
            expectation.fulfill()
        }
        
        // when
        galleryPresenter.viewDidLoad()
        wait(for: [expectation], timeout: 1.0)
        
        // then
        XCTAssertTrue(imageLoaderMock.invokedImage)
    }
    
    func testDidTapCellLogicWithImage() throws {
        // given
        let expectation = expectation(description: "testDidTapCellLogicWithImage")

        let photos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1", image: UIImage())
        ]
        paginatorHelperMock.stubbedLoadInitialDataResult = .success(photos)

        // when
        galleryPresenter.viewDidLoad()
        paginatorHelperMock.invokedLoadInitialDataCallBack = {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
        
        galleryPresenter.didTapCell(indexPath: 0)

        // then
        XCTAssertTrue(mainGalleryRouter.invokedMoveToDetailsImageView)
    }
    
    func testDidTapCellLogicWithoutImage() throws {
        // given

        let photos: [FlickrPhoto] = []
        paginatorHelperMock.stubbedLoadInitialDataResult = .success(photos)

        // when
        galleryPresenter.viewDidLoad()
        galleryPresenter.didTapCell(indexPath: 0)
        
        // then
        XCTAssertFalse(mainGalleryRouter.invokedMoveToDetailsImageView)
    }
}
