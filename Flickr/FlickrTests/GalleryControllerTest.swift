//
//  GalleryControllerTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

import XCTest
@testable import Flickr

private extension Int {
    static let customHeight = 200
    static let customWidth = 100
}
class GalleryControllerTest: XCTestCase {

    private var galleryController: GalleryController!
    
    private var galleryPresenterMock: GalleryPresenterMock!
    
    override func setUp() {
        super.setUp()
        
        galleryController = GalleryController()
        galleryPresenterMock = GalleryPresenterMock()
        
        galleryController.presenter = galleryPresenterMock
    }
    
    
    override func tearDown() {
        super.tearDown()
        
        galleryPresenterMock = nil
        galleryController = nil
    }
    
    func testPresenterViewDidLoadCaleed() throws {
        // given
        
        // when
        galleryController.viewDidLoad()
        
        // then
        XCTAssertTrue(galleryPresenterMock.invokedViewDidLoad)
    }

    func testTitle() throws {
        // given
        
        // when
        galleryController.viewDidLoad()
        
        // then
        XCTAssertEqual(galleryController.title, "Flickr's Gallery")
    }
    
    func testTypeOfCell() throws {
        // given
        galleryPresenterMock.stubbedPhotos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "2")
        ]
        
        // when
        galleryController.viewDidLoad()
        guard let tableView = galleryController.view.subviews.first as? UITableView else {
            XCTFail("Не отобразилась tableView")
            return
        }
        
        // then
        XCTAssertTrue(galleryController.tableView(tableView, cellForRowAt: .zero) is ImageCell)
    }
    
    func testTableView() throws {
        // given
        
        // when
        galleryController.viewDidLoad()
        
        // then
        XCTAssertTrue(galleryController.view.subviews.first is UITableView)
    }
    
    func testCountOfPhotos() throws {
        // given
        galleryPresenterMock.stubbedPhotos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1"),
            FlickrPhoto.getFlickrPhotoStub(photoId: "2")
        ]
        // when
        galleryController.viewDidLoad()
        
        guard let tableView = galleryController.view.subviews.first as? UITableView else {
            XCTFail("Не отобразилась tableView")
            return
        }
        
        // then
        XCTAssertEqual(galleryController.tableView(tableView, numberOfRowsInSection: 0), 2)
    }
    
    func testHeightOfCell() throws {
        // given
        galleryPresenterMock.stubbedPhotos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1", height: .customHeight, width: .customWidth)
        ]
        // when
        galleryController.viewDidLoad()
        
        guard let tableView = galleryController.view.subviews.first as? UITableView else {
            XCTFail("Не отобразилась tableView")
            return
        }
        
        let koef = CGFloat(Int.customHeight)/CGFloat(Int.customWidth)
        let currentHeight = koef*galleryController.view.bounds.width
        
        // then
        XCTAssertEqual(galleryController.tableView(tableView, heightForRowAt: .zero), currentHeight)
    }
    
    func testCallLoadPhotos() throws {
        // given
        galleryPresenterMock.stubbedPhotos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1")
        ]
        let expectation = expectation(description: "Loading photos")
        // when
        
        guard let tableView = galleryController.view.subviews.first as? UITableView else {
            XCTFail("Не отобразилась tableView")
            return
        }
        galleryPresenterMock.callBackForLoadPhotosExpectation = {
            expectation.fulfill()
        }
        
        galleryController.scrollViewDidEndDragging(tableView, willDecelerate: true)
        wait(for: [expectation], timeout: 1.0)
        
        // then
        XCTAssertTrue(galleryPresenterMock.invokedLoadPhotos)
    }
    
    func testDidTapCellLogic() throws {
        // given
        galleryPresenterMock.stubbedPhotos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1")
        ]
        
        // when
        guard let tableView = galleryController.view.subviews.first as? UITableView else {
            XCTFail("Не отобразилась tableView")
            return
        }
        
        galleryController.tableView(tableView, didSelectRowAt: .zero)
        
        // then
        XCTAssertTrue(galleryPresenterMock.invokedDidTapCell)
    }
    
    func testCallClearImage() throws {
        // given
        galleryPresenterMock.stubbedPhotos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1")
        ]
        
        let expectation = expectation(description: "ClearImage")
        galleryPresenterMock.callBackForClearImageExpectation = {
            expectation.fulfill()
        }
        
        // when
        guard let tableView = galleryController.view.subviews.first as? UITableView else {
            XCTFail("Не отобразилась tableView")
            return
        }
        
        _ = galleryController.tableView(tableView, cellForRowAt: .zero)
        
        wait(for: [expectation], timeout: 1.0)
        
        // then
        XCTAssertTrue(galleryPresenterMock.invokedClearImage)
    }
    
    func testGetImageFor() throws {
        // given
        galleryPresenterMock.stubbedPhotos = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1")
        ]
        
        let expectation = expectation(description: "GetImageFor")
        galleryPresenterMock.callBackForGetImageForExpectation = {
            expectation.fulfill()
        }
        
        // when
        guard let tableView = galleryController.view.subviews.first as? UITableView else {
            XCTFail("Не отобразилась tableView")
            return
        }
        
        _ = galleryController.tableView(tableView, cellForRowAt: .zero)
        
        wait(for: [expectation], timeout: 1.0)
        
        // then
        XCTAssertTrue(galleryPresenterMock.invokedGetImageFor)
    }
}

private extension IndexPath {
    static let zero = IndexPath(row: .zero, section: .zero)
}
