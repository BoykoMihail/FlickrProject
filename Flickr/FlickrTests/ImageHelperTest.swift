//
//  ImageHelperTest.swift
//  FlickrTests
//
//  Created by Михаил Бойко on 10.07.2022.
//

@testable import Flickr
import XCTest

private extension UIImage {
    static let defaultTestImage = UIImage()
}

private extension String {
    // swiftlint:disable line_length
    static let photoUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1111&extras=url_m&per_page=30&page=1&format=json&nojsoncallback=1"
    // swiftlint:enable line_length
}

class ImageHelperTest: XCTestCase {
    private var imageHelper: ImageHelper!
    
    private var imageLoaderMock: ImageLoaderMock!

    override func setUp() {
        super.setUp()
        imageLoaderMock = ImageLoaderMock()
        imageHelper = ImageHelper(imageLoader: imageLoaderMock)
    }

    override func tearDown() {
        super.tearDown()

        imageHelper = nil
        imageLoaderMock = nil
    }

    func testUpdatePhotosModel() {
        // given
        let expectedinvokedImageCount = 3
       
        let predicate = NSPredicate { _, _ in
            self.imageLoaderMock.invokedImageCount == expectedinvokedImageCount
        }
        let testUpdatePhotosModelExpectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: imageLoaderMock
        )
        
        let flickrPhoto = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1", photoUrl: .photoUrl),
            FlickrPhoto.getFlickrPhotoStub(photoId: "2", photoUrl: .photoUrl),
            FlickrPhoto.getFlickrPhotoStub(photoId: "3", photoUrl: .photoUrl)
        ]
        // when
        imageHelper.updatePhotosModel(flickrPhoto: flickrPhoto)
        wait(for: [testUpdatePhotosModelExpectation], timeout: 1.0)

        // when
        XCTAssertEqual(imageLoaderMock.invokedImageCount, expectedinvokedImageCount)
    }
    
    func testGetImageFor() {
        // given
        let predicate = NSPredicate { _, _ in
            self.imageLoaderMock.invokedImage == true
        }
        let testGetImageForExpectation = XCTNSPredicateExpectation(
            predicate: predicate,
            object: imageLoaderMock
        )
        
        let flickrPhoto = [
            FlickrPhoto.getFlickrPhotoStub(photoId: "1", photoUrl: .photoUrl),
            FlickrPhoto.getFlickrPhotoStub(photoId: "2", photoUrl: .photoUrl),
            FlickrPhoto.getFlickrPhotoStub(photoId: "3", photoUrl: .photoUrl)
        ]
        // when
        imageHelper.updatePhotosModel(flickrPhoto: flickrPhoto)
        wait(for: [testGetImageForExpectation], timeout: 3.0)

        // when
        XCTAssertTrue(imageLoaderMock.invokedImage)
    }
}
