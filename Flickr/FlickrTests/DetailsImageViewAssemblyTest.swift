//
//  DetailsImageViewAssemblyTest.swift
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

class DetailsImageViewAssemblyTest: XCTestCase {
    private var detailsImageViewAssembly: DetailsImageViewAssembly!

    override func setUp() {
        super.setUp()

        detailsImageViewAssembly = DetailsImageViewAssembly()
    }

    override func tearDown() {
        super.tearDown()

        detailsImageViewAssembly = nil
    }

    func testAssembly() throws {
        // given
        let viewModel = DetailsViewModel(
            image: .defaultTestImage,
            name: .defaultTestName,
            size: .defaultTestSize
        )

        // when
        let viewController = detailsImageViewAssembly.assembly(viewModel: viewModel)

        // then
        guard let galleryController = viewController as? ImageDetailViewController else {
            XCTFail("Assembler вернул не ImageDetailViewController")
            return
        }

        XCTAssertTrue(galleryController.presenter is ImageDetailViewPresenter)
    }
}
