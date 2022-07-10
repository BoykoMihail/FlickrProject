//
//  ImageDetailViewPresenterTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 27.06.2022.
//

@testable import Flickr
import XCTest

private extension CGSize {
    static let defaultTestSize = CGSize(width: 200, height: 100)
}

private extension String {
    static let defaultTestName = "Name Test"
}

private extension UIImage {
    static let defaultTestImage = UIImage()
}

class ImageDetailViewPresenterTest: XCTestCase {
    private var imageDetailViewPresenter: ImageDetailViewPresenter!

    private var imageDetailViewMock: ImageDetailViewMock!

    @MainActor override func setUp() {
        super.setUp()

        let viewModel = DetailsViewModel(image: .defaultTestImage, name: .defaultTestName, size: .defaultTestSize)
        imageDetailViewPresenter = ImageDetailViewPresenter(viewModel: viewModel)

        imageDetailViewMock = ImageDetailViewMock()

        imageDetailViewPresenter.view = imageDetailViewMock
    }

    override func tearDown() {
        super.tearDown()

        imageDetailViewPresenter = nil
        imageDetailViewMock = nil
    }

    @MainActor func testViewDidLoad() throws {
        // given
        imageDetailViewMock.stubbedViewWidth = CGSize.defaultTestSize.width
        // when
        imageDetailViewPresenter.viewDidLoad()

        // then
        XCTAssertTrue(imageDetailViewMock.invokedUpdateImage)
        XCTAssertTrue(imageDetailViewMock.invokedUpdateLabel)

        XCTAssertEqual(imageDetailViewMock.invokedUpdateImageParameters?.image, .defaultTestImage)
        XCTAssertEqual(imageDetailViewMock.invokedUpdateImageParameters?.size.width, CGSize.defaultTestSize.width)
        XCTAssertEqual(imageDetailViewMock.invokedUpdateImageParameters?.size.height, CGSize.defaultTestSize.height)

        XCTAssertEqual(imageDetailViewMock.invokedUpdateLabelParameters?.string, .defaultTestName)
    }
}
