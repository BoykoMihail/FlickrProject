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
    
    private var flickrServiceMock: FlickrServiceMock!
    private var imageLoaderMock: ImageLoaderMock!
    private var mainGalleryRouter: MainGalleryRouterMock!
    private var galleryViewMock: GalleryViewMock!

    override func setUp() {
        super.setUp()
        
        flickrServiceMock = FlickrServiceMock()
        imageLoaderMock = ImageLoaderMock()
        mainGalleryRouter = MainGalleryRouterMock()
        galleryViewMock = GalleryViewMock()
        
        galleryPresenter = GalleryPresenter(
            flickrService: flickrServiceMock,
            imageLoader: imageLoaderMock,
            router: mainGalleryRouter)
        
        galleryPresenter.viewController = galleryViewMock
    }

    func testIsUpdatingLogic() throws {
        // given
        
        // when
        galleryPresenter.viewDidLoad()
        galleryPresenter.viewDidLoad()
        galleryPresenter.viewDidLoad()
        
        // then
        XCTAssertEqual(flickrServiceMock.invokedFetchPhotosCount, 1)
    }
    
    func testCallFetchPhotos() throws {
        // given
        
        // when
        galleryPresenter.viewDidLoad()
        
        // then
        XCTAssertTrue(flickrServiceMock.invokedFetchPhotos)
    }
    
    func testUpdatePhotosAfterLoadPhotos() throws {
        // given
        let photos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "2"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "3"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "4"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "5")
        ]
        flickrServiceMock.stubbedFetchPhotosOnCompletionResult = (nil, photos)
        // when
        galleryPresenter.viewDidLoad()
        
        // then
        XCTAssertEqual(galleryPresenter.countOfPhotos, photos.count)
    }
    
    func testUpdatePhotosAfterLoadPhotosError() throws {
        // given
        let photos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "2"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "3"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "4"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "5")
        ]
        flickrServiceMock.stubbedFetchPhotosOnCompletionResult = (TestError.testError, photos)
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
        flickrServiceMock.stubbedFetchPhotosOnCompletionResult = (nil, photos)
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
        let expectation = expectation(description: "DownloadImage")

        let photos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1")
        ]
        flickrServiceMock.stubbedFetchPhotosOnCompletionResult = (nil, photos)
        imageLoaderMock.stubbedDownloadImageCompletionResult = (TestError.testError, UIImage())
        imageLoaderMock.callBackForDownloadImageExpectation = {
            expectation.fulfill()
        }
        
        // when
        galleryPresenter.viewDidLoad()
        wait(for: [expectation], timeout: 1.0)
        
        // then
        XCTAssertTrue(imageLoaderMock.invokedDownloadImage)
    }
    
//    func testUpdatePhotosDataAfterDownloadImage() throws {
//        // given
//        let expectation = expectation(description: "DownloadImage")
//
//        let photos = [
//            FlickrPhoto.getFlickrPhotoStub(photoId: "1")
//        ]
//        galleryPresenter.photos = photos
//        imageLoaderMock.stubbedDownloadImageCompletionResult = (nil, UIImage())
//        // when
//        galleryPresenter.getImageFor(index: 0) {_ in
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 1.0)
//
//        // then
//        XCTAssertTrue(imageLoaderMock.invokedDownloadImage)
//        XCTAssertNotNil(galleryPresenter.photos.first?.image)
//    }
//
//    func testDontUpdatePhotosDataAfterDownloadImageError() throws {
//        // given
//        let expectation = expectation(description: "DownloadImage")
//
//        let photos = [
//            FlickrPhoto.getFlickrPhotoStub(photoId: "1")
//        ]
//        galleryPresenter.photos = photos
//        imageLoaderMock.stubbedDownloadImageCompletionResult = (TestError.testError, UIImage())
//
//        imageLoaderMock.callBackForDownloadImageExpectation = {
//                expectation.fulfill()
//            }
//        // when
//        galleryPresenter.getImageFor(index: 0) {_ in }
//        wait(for: [expectation], timeout: 1.0)
//
//        // then
//        XCTAssertTrue(imageLoaderMock.invokedDownloadImage)
//        XCTAssertNil(galleryPresenter.photos.first?.image)
//    }
//
//    func testCallDownloadImageFromGetImageForWithoutImage() throws {
//        // given
//        let expectation = expectation(description: "DownloadImage")
//
//        let photos = [
//            FlickrPhoto.getFlickrPhotoStub(photoId: "1")
//        ]
//        galleryPresenter.photos = photos
//        imageLoaderMock.stubbedDownloadImageCompletionResult = (TestError.testError, UIImage())
//        imageLoaderMock.callBackForDownloadImageExpectation = {
//            expectation.fulfill()
//        }
//
//        // when
//        galleryPresenter.getImageFor(index: 0) { _ in }
//        wait(for: [expectation], timeout: 1.0)
//
//        // then
//        XCTAssertTrue(imageLoaderMock.invokedDownloadImage)
//    }
//
//    func testCallDownloadImageFromGetImageForWithImage() throws {
//        // given
//        let expectation = expectation(description: "DownloadImage")
//
//        let photos = [
//            FlickrPhoto.getFlickrPhotoStub(photoId: "1", image: UIImage())
//        ]
//        galleryPresenter.photos = photos
//
//        // when
//        galleryPresenter.getImageFor(index: 0) { _ in
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 1.0)
//
//        // then
//        XCTAssertFalse(imageLoaderMock.invokedDownloadImage)
//    }
    
    func testDidTapCellLogicWithImage() throws {
        // given

        let photos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1", image: UIImage())
        ]
        flickrServiceMock.stubbedFetchPhotosOnCompletionResult = (nil, photos)
        
        // when
        galleryPresenter.viewDidLoad()
        galleryPresenter.didTapCell(indexPath: 0)
        
        // then
        XCTAssertTrue(mainGalleryRouter.invokedMoveToDetailsImageView)
    }
    
    func testDidTapCellLogicWithoutImage() throws {
        // given

        let photos: [FlickrPhoto] = []
        flickrServiceMock.stubbedFetchPhotosOnCompletionResult = (nil, photos)
        
        // when
        galleryPresenter.viewDidLoad()
        galleryPresenter.didTapCell(indexPath: 0)
        
        // then
        XCTAssertFalse(mainGalleryRouter.invokedMoveToDetailsImageView)
    }
}
