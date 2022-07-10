//
//  GalleryControllerTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 26.06.2022.
//

@testable import Flickr
import XCTest

private extension CGFloat {
    static let customHeight: CGFloat = 200
    static let customWidth: CGFloat = 100
}

private extension IndexPath {
    static let zero = IndexPath(row: .zero, section: .zero)
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

    func testPresenterViewDidLoadCaled() throws {
        // given
        
        let predicate = NSPredicate { _, _ -> Bool in
            return self.galleryPresenterMock.invokedViewDidLoad == true
        }
        let publishExpectation = XCTNSPredicateExpectation(predicate: predicate, object: galleryPresenterMock)
        
        // when
            
        galleryController.viewDidLoad()
        wait(for: [publishExpectation], timeout: 3.0)
        
        // then
        XCTAssertTrue(galleryPresenterMock.invokedViewDidLoad)
    }

    func testTitle() throws {
        // given
        galleryPresenterMock.stubbedTitle = "Flickr's Gallery"
        // when
        galleryController.viewDidLoad()

        // then
        XCTAssertEqual(galleryController.title, "Flickr's Gallery")
    }

    func testTypeOfCell() throws {
        // given
        let task = Task {
            UIImage()
        }
        galleryPresenterMock.stubbedCountOfPhotos = 2
        galleryPresenterMock.stubbedGetCellViewModelForResult = .init(getImageblock: { blok in
            blok(task)
        })
        galleryPresenterMock.stubbedGetCellHeightResult = .customHeight

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
        let task = Task {
            UIImage()
        }
        galleryPresenterMock.stubbedCountOfPhotos = 2
        galleryPresenterMock.stubbedGetCellViewModelForResult = .init(getImageblock: { blok in
            blok(task)
        })
        galleryPresenterMock.stubbedGetCellHeightResult = .customHeight
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
        let task = Task {
            UIImage()
        }
        galleryPresenterMock.stubbedCountOfPhotos = 2
        galleryPresenterMock.stubbedGetCellViewModelForResult = .init(getImageblock: { blok in
            blok(task)
        })
        galleryPresenterMock.stubbedGetCellHeightResult = .customHeight

        // when
        galleryController.viewDidLoad()

        guard let tableView = galleryController.view.subviews.first as? UITableView else {
            XCTFail("Не отобразилась tableView")
            return
        }

        // then
        XCTAssertEqual(galleryController.tableView(tableView, heightForRowAt: .zero), .customHeight)
    }

    func testDidTapCellLogic() throws {
        // given
        let task = Task {
            UIImage()
        }
        galleryPresenterMock.stubbedCountOfPhotos = 2
        galleryPresenterMock.stubbedGetCellViewModelForResult = .init(getImageblock: { blok in
            blok(task)
        })
        galleryPresenterMock.stubbedGetCellHeightResult = .customHeight

        // when
        guard let tableView = galleryController.view.subviews.first as? UITableView else {
            XCTFail("Не отобразилась tableView")
            return
        }

        galleryController.tableView(tableView, didSelectRowAt: .zero)

        // then
        XCTAssertTrue(galleryPresenterMock.invokedDidTapCell)
    }
}
