//
//  ImageDetailViewControllerTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 27.06.2022.
//

@testable import Flickr
import XCTest

class ImageDetailViewControllerTest: XCTestCase {
    private var imageDetailViewController: ImageDetailViewController!

    private var imageDetailViewPresenterMock: ImageDetailViewPresenterMock!

    override func setUp() {
        super.setUp()

        imageDetailViewController = ImageDetailViewController()

        imageDetailViewPresenterMock = ImageDetailViewPresenterMock()

        imageDetailViewController.presenter = imageDetailViewPresenterMock
    }

    override func tearDown() {
        super.tearDown()

        imageDetailViewController = nil
        imageDetailViewPresenterMock = nil
    }

    func testPresenterViewDidLoadCaleed() throws {
        // given

        // when
        imageDetailViewController.viewDidLoad()

        // then
        XCTAssertTrue(imageDetailViewPresenterMock.invokedViewDidLoad)
    }

    @MainActor func testTitle() throws {
        // given
        let expectedTitle = "Label 1"
        // when
        imageDetailViewController.updateLabel(with: expectedTitle)

        // then
        XCTAssertEqual(imageDetailViewController.title, expectedTitle)
    }

    func testImageView() throws {
        // given

        // when
        imageDetailViewController.viewDidLoad()

        // then
        XCTAssertTrue(imageDetailViewController.view.subviews.first is UIImageView)
    }

    @MainActor func testUpdateImage() throws {
        // given
        let expectedImage = UIImage()
        let parametrSize = CGSize(width: 200, height: 100)

        let koef = parametrSize.height / parametrSize.width
        let currentHeight = koef * imageDetailViewController.view.bounds.width

        let expectedSize = CGSize(width: imageDetailViewController.view.bounds.width, height: currentHeight)
        let size = CGSize(width: expectedSize.width, height: expectedSize.height)
        // when
        imageDetailViewController.updateImage(with: expectedImage, size: size)

        // then

        guard let imageView = imageDetailViewController.view.subviews.first as? UIImageView else {
            XCTFail("Не нашел UIImageView")
            return
        }

        XCTAssertEqual(imageView.image, expectedImage)
        XCTAssertEqual(imageView.bounds.size, expectedSize)
    }
}
